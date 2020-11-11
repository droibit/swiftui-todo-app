//
//  TasksDataSourceImpl.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/02.
//

import GRDB
import Foundation
import RxGRDB
import RxSwift
import RxRelay

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
                }.asObservable()
                .do(onNext: { _ in print("loaded task(s)") })
            }
            .share(replay: 1, scope: .forever)
    }()
    
    init(databaseQueue: DatabaseQueue,
         schedulers: SchedulerProvider,
         reloadEventSink: PublishRelay<Void>) {
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
                try db.create(table: TaskEntity.databaseTableName, ifNotExists: true) { t in
                    t.column(Columns.id.name, .text).primaryKey()
                    t.column(Columns.title.name, .text).notNull()
                    t.column(Columns.description.name, .text).notNull()
                    t.column(Columns.completed.name, .boolean).notNull()
                    t.column(Columns.createdAt.name, .date).notNull()
                }
            }
        } catch {
            print("Create db error: \(error)")
        }
    }
    
    func getTask(id: String) -> Single<Task?> {
        self.databaseQueue.rx.read(observeOn: self.schedulers.current) { db in
            try TaskEntity.fetchOne(db, key: id)
        }
    }
    
    func createTask(title: String, description: String) -> Completable {
        databaseQueue.rx.write(observeOn: schedulers.current) { db in
            var entity = TaskEntity(title: title, description: description)
            try entity.insert(db)
        }
        .do(onSuccess: { _ in self.reloadEventSink.accept(()) })
        .asCompletable()
    }
    
    func updateTask(id: String, title: String, description: String) -> Completable {
        updateTask(id: id) { db, task in
            try task.copy(title: title, description: description).update(db, columns: [
                Columns.title,
                Columns.description
            ])
        }
    }
    
    func activateTask(id: String) -> Completable {
        updateTask(id: id) { db, task in
            try task.copy(completed: false).update(db, columns: [
                Columns.completed
            ])
        }
    }
    
    func completeTask(id: String) -> Completable {
        updateTask(id: id) { db, task in
            try task.copy(completed: true).update(db, columns: [
                Columns.completed
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
        databaseQueue.rx.read(observeOn: self.schedulers.current) { db in
            try TaskEntity.fetchOne(db, key: id)
        }.flatMap { task in
            self.databaseQueue.rx.write(observeOn: self.schedulers.current) { db in
                try action(db, task!)
            }
        }
        .do(onSuccess: { _ in self.reloadEventSink.accept(()) })
        .asCompletable()
    }
}

private extension Task {
    func copy(title: String? = nil, description: String? = nil, completed: Bool? = nil) -> Task {
        Task(
            id: self.id,
            title: title ?? self.title,
            description: description ?? self.description,
            isCompleted: completed ?? self.isCompleted,
            createdAt: self.createdAt
        )
    }
}
