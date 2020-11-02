//
//  TasksDataSourceImpl.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/02.
//

import GRDB
import Foundation
import RxSwift

private typealias Columns = TaskEntity.Columns

class LocalTasksDataSource: TasksDataSource {
    
    private let databaseQueue: DatabaseQueue
    
    init(databaseQueue: DatabaseQueue) {
        self.databaseQueue = databaseQueue
    }
    
    var tasks: Observable<Task> {
        Observable.empty()
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
    
    func createTask(title: String, description: String) -> Completable {
        Completable.empty()
    }
    
    func updateTask(taskId: String, title: String, description: String) -> Completable {
        Completable.empty()
    }
    
    func activateTask(id: String) -> Completable {
        Completable.empty()
    }
    
    func completeTask(id: String) -> Completable {
        Completable.empty()
    }
    
    func deleteTask(id: String) -> Completable {
        Completable.empty()
    }
    
    func clearCompletedTasks() -> Completable {
        Completable.empty()
    }
}
