//
//  DeleteTaskResult.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/12/08.
//

import Foundation

enum DeleteTaskResult: Equatable {
    case none
    case inProgress
    case success
    case error(message: String)

    var isInProgress: Bool {
        self == .inProgress
    }
}
