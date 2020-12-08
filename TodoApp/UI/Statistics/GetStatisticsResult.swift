//
//  GetStatisticsResult.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/12/09.
//

import Core
import Foundation

enum GetStatisticsResult: Equatable {
    case inProgress(initial: Bool)
    case success(uiState: StatisticsUiState)
    case error(message: String)
}

extension GetStatisticsResult {
    init(error: Error) {
        let tasksError = error as! TasksError
        self = .error(message: tasksError.message)
    }
}
