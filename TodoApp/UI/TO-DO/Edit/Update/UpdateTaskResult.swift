//
//  UpdateTaskResult.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/12/07.
//

import Core
import Foundation

enum UpdateTaskResult: Equatable {
    case none
    case inProgress
    case success
    case error(message: String)

    var isInProgress: Bool {
        self == .inProgress
    }
}

extension UpdateTaskResult {
    init(error: Error) {
        let tasksError = error as! TasksError
        self = .error(message: tasksError.message)
    }
}
