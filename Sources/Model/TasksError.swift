//
//  TasksError.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/13.
//

import Foundation

struct TasksError: Error, CustomStringConvertible {
    let message: String

    var description: String {
        message
    }
}
