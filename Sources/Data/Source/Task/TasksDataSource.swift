//
//  TasksDataSource.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/01.
//

import Foundation
import RxSwift

protocol TasksDataSource {
    
    var tasks: Observable<[Task]> { get }
    
    func initialize()
    
    func createTask(title: String, description: String) -> Completable

    func updateTask(id: String, title: String, description: String) -> Completable

    func activateTask(id: String) -> Completable

    func completeTask(id: String) -> Completable

    func deleteTask(id: String) -> Completable

    func clearCompletedTasks() -> Completable
}
