//
//  ToggleTaskCompletedResult.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/12/01.
//

import Core
import Foundation

enum ToggleTaskCompletedResult: Equatable {
    case none
    case inProgress
    case success
    case error(message: String)

    var isInProgress: Bool {
        self == .inProgress
    }
}
