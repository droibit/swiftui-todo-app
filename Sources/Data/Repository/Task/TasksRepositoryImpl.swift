//
//  TasksRepositoryImpl.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/11.
//

import Foundation
import RxSwift

class TasksRepositoryImpl: TasksRepository {
    
    private let localDataSource: TasksDataSource
    
    private let schedulers: SchedulerProvider
    
    init(localDataSource: TasksDataSource,
         schedulers: SchedulerProvider) {
        self.localDataSource = localDataSource
        self.schedulers = schedulers
    }
    
    var tasks: Observable<[Task]> {
        localDataSource.tasks
            .subscribeOn(schedulers.background)
    }
    
    func getTask(taskId: String) -> Single<Task> {
        localDataSource.getTask(id: taskId)
            .map {
                guard let task = $0 else {
                    throw TasksError(message: "Task(id=\(taskId)) not found.")
                }
                return task
            }
            .subscribeOn(schedulers.background)
    }
    
    func createTask(title: String, description: String) -> Completable {
        localDataSource.createTask(title: title, description: description)
            .subscribeOn(schedulers.background)
    }
    
    func updateTask(taskId: String, title: String, description: String) -> Completable {
        localDataSource.updateTask(id: taskId, title: title, description: description)
            .subscribeOn(schedulers.background)
    }
    
    func activateTask(taskId: String) -> Completable {
        localDataSource.activateTask(id: taskId)
            .subscribeOn(schedulers.background)
    }
    
    func completeTask(taskId: String) -> Completable {
        localDataSource.completeTask(id: taskId)
            .subscribeOn(schedulers.background)
    }
    
    func deleteTask(taskId: String) -> Completable {
        localDataSource.deleteTask(id: taskId)
            .subscribeOn(schedulers.background)
    }
    
    func clearCompletedTasks() -> Completable {
        localDataSource.clearCompletedTasks()
            .subscribeOn(schedulers.background)

    }
}
