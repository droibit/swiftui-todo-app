//
//  LocalTasksDataSource.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/02.
//

import Foundation
import GRDB
import RxGRDB
import RxRelay
import RxSwift

private typealias Columns = TaskEntity.Columns

class LocalTasksDataSource: TasksDataSource {
    private let databaseQueue: DatabaseQueue

    private let schedulers: SchedulerProvider

    private let reloadEventSink: PublishRelay<Void>

    private lazy var tasksSink: Observable<[Task]> = {
        reloadEventSink.startWith(())
            .flatMap { _ in
                self.databaseQueue.rx.read(observeOn: self.schedulers.current) { db in
                    try TaskEntity.fetchAll(db)
                }
                .catchError { .error(TasksError(error: $0)) }
                .asObservable()
            }
            .share(replay: 1, scope: .forever)
    }()

    init(databaseQueue: DatabaseQueue,
         schedulers: SchedulerProvider,
         reloadEventSink: PublishRelay<Void>)
    {
        self.databaseQueue = databaseQueue
        self.schedulers = schedulers
        self.reloadEventSink = reloadEventSink
    }

    var tasks: Observable<[Task]> {
        tasksSink
    }

    func initialize() {
        do {
            try databaseQueue.write { db in
                try db.create(table: TaskEntity.databaseTableName, ifNotExists: true) { table in
                    table.column(Columns.id.name, .text).primaryKey()
                    table.column(Columns.title.name, .text).notNull()
                    table.column(Columns.description.name, .text).notNull()
                    table.column(Columns.completed.name, .boolean).notNull()
                    table.column(Columns.createdAt.name, .date).notNull()
                }
            }
        } catch {
            print("Create db error: \(error)")
        }
    }

    func getTask(id: String) -> Single<Task?> {
        databaseQueue.rx.read(observeOn: schedulers.current) { db in
            try TaskEntity.fetchOne(db, key: id)
        }.catchError { .error(TasksError(error: $0)) }
    }

    func createTask(title: String, description: String) -> Completable {
        databaseQueue.rx.write(observeOn: schedulers.current) { db in
            var entity = TaskEntity(title: title, description: description)
            try entity.insert(db)
        }
        .catchError { .error(TasksError(error: $0)) }
        .do(onSuccess: { _ in self.reloadEventSink.accept(()) })
        .asCompletable()
    }

    func updateTask(id: String, title: String, description: String) -> Completable {
        updateTask(id: id) { db, task in
            try task.copy(title: title, description: description).update(db, columns: [
                Columns.title,
                Columns.description,
            ])
        }
    }

    func activateTask(id: String) -> Completable {
        updateTask(id: id) { db, task in
            try task.copy(completed: false).update(db, columns: [
                Columns.completed,
            ])
        }
    }

    func completeTask(id: String) -> Completable {
        updateTask(id: id) { db, task in
            try task.copy(completed: true).update(db, columns: [
                Columns.completed,
            ])
        }
    }

    func deleteTask(id: String) -> Completable {
        databaseQueue.rx.write(observeOn: schedulers.current) { db in
            try TaskEntity.deleteOne(db, key: id)
        }
        .do(onSuccess: { _ in self.reloadEventSink.accept(()) })
        .asCompletable()
    }

    func clearCompletedTasks() -> Completable {
        databaseQueue.rx.write(observeOn: schedulers.current) { db in
            try TaskEntity.filter(Columns.completed == true)
                .deleteAll(db)
        }
        .do(onSuccess: { _ in self.reloadEventSink.accept(()) })
        .asCompletable()
    }

    private func updateTask(id: String, action: @escaping (Database, TaskEntity) throws -> Void) -> Completable {
        databaseQueue.rx.read(observeOn: schedulers.current) { db in
            try TaskEntity.fetchOne(db, key: id)
        }.flatMap { task in
            self.databaseQueue.rx.write(observeOn: self.schedulers.current) { db in
                try action(db, task!)
            }
        }
        .catchError { .error(TasksError(error: $0)) }
        .do(onSuccess: { _ in self.reloadEventSink.accept(()) })
        .asCompletable()
    }
}

private extension Task {
    func copy(title: String? = nil, description: String? = nil, completed: Bool? = nil) -> Task {
        Task(
            id: id,
            title: title ?? self.title,
            description: description ?? self.description,
            isCompleted: completed ?? isCompleted,
            createdAt: createdAt
        )
    }
}

private extension TasksError {
    init(error: Error) {
        if let dbError = error as? DatabaseError {
            self.init(message: dbError.description)
        } else {
            self.init(message: "Unknown error: \(error)")
        }
    }
}
