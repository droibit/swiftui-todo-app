//
//  TasksUiState.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/15.
//

import Foundation
import SwiftUI

struct TasksUiState {
    let sourceTasks: [Task]
    let filter: TasksFilter
    let sorting: TasksSorting

    // TODO: get filtered & sorted tasks
    var tasks: [Task] {
        sourceTasks
    }
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

    var label: String {
        switch self {
        case .all:
            return L10n.Tasks.Filter.all
        case .active:
            return L10n.Tasks.Filter.active
        case .completed:
            return L10n.Tasks.Filter.completed
        }
    }
}

// MARK: - TasksSorting

enum TasksSorting {
    enum Order {
        case asc
        case desc

        var icon: Image {
            switch self {
            case .asc:
                return Image(systemName: "arrow.up")
            case .desc:
                return Image(systemName: "arrow.down")
            }
        }
    }

    case title(order: Order)
    case createdDate(order: Order)

    var label: String {
        switch self {
        case .title:
            return L10n.Tasks.SortBy.title
        case .createdDate:
            return L10n.Tasks.SortBy.createdDate
        }
    }

    var order: Order {
        switch self {
        case let .title(order):
            return order
        case let .createdDate(order):
            return order
        }
    }
}
