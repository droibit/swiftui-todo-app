//
//  TasksUiState.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/15.
//

import Core
import Foundation
import SwiftUI

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
            Image(systemName: (self == .asc) ? "arrow.up" : "arrow.down")
        }

        func toggled() -> Order {
            (self == .asc) ? .desc : .asc
        }

        mutating func toggle() {
            self = (self == .asc) ? .desc : .asc
        }
    }

    static func allCases(_ order: Order) -> [TasksSorting] {
        [.title(order: order), .createdDate(order: order)]
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

    mutating func toggleOrder() {
        switch self {
        case let .title(order):
            self = .title(order: order.toggled())
        case let .createdDate(order):
            self = .createdDate(order: order.toggled())
        }
    }
}

// MARK: - Convert tasks

extension Array where Element == Task {
    func filter(by filter: TasksFilter) -> [Element] {
        self.filter { task in
            switch filter {
            case .all:
                return true
            case .active:
                return task.isActive
            case .completed:
                return task.isCompleted
            }
        }
    }

    func sorted(by sorting: TasksSorting) -> [Element] {
        sorted { lhs, rhs in
            switch sorting {
            case let .title(order):
                return (order == .asc)
                    ? lhs.title.lowercased() < rhs.title.lowercased()
                    : rhs.title.lowercased() < lhs.title.lowercased()
            case let .createdDate(order):
                return (order == .asc)
                    ? lhs.createdAt < rhs.createdAt
                    : rhs.createdAt < lhs.createdAt
            }
        }
    }
}
