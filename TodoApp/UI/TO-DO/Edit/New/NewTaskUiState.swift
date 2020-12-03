//
//  NewTaskUiState.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/30.
//

import Foundation

enum MakeTaskResult: Equatable {
    case none
    case inProgress
    case success
    case error(message: String)

    var isInProgress: Bool {
        self == .inProgress
    }
}
