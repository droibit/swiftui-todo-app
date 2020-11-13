//
//  TasksRepository.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/11.
//

import Foundation
import RxSwift

protocol TasksRepository {
    var tasks: Observable<[Task]> { get }

    func getTask(taskId: String) -> Single<Task>

    func createTask(title: String, description: String) -> Completable

    func updateTask(taskId: String, title: String, description: String) -> Completable

    func activateTask(taskId: String) -> Completable

    func completeTask(taskId: String) -> Completable

    func deleteTask(taskId: String) -> Completable

    func clearCompletedTasks() -> Completable
}
