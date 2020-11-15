//
//  TasksUiState.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/15.
//

import Foundation

struct TasksUiState {
    let sourceTasks: [Task]
    let filter: TasksFilter
    let sorting: TasksSorting
    
    // TODO: get filtered & sorted tasks
}

enum TasksUiStateResult {
    case inProgress(initial: Bool)
    case success(uiState: TasksUiState)
    case error(message: String)
}

// MARK: - TasksFilter

enum TasksFilter: Int, CaseIterable {
    case all
    case active
    case completed
}

// MARK: - TasksSorting

enum TasksSorting {
    enum Order {
        case asc
        case desc
    }

    case title(order: Order)
    case createdDate(order: Order)

    var order: Order {
        switch self {
        case let .title(order):
            return order
        case let .createdDate(order):
            return order
        }
    }
}
