//
//  GetTasksResult.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/12/08.
//

import Core
import Foundation

enum GetTasksResult {
    case inProgress(initial: Bool)
    case success(tasks: [Task])
    case error(message: String)
}
