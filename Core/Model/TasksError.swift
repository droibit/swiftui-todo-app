//
//  TasksError.swift
//  Core
//
//  Created by Shinya Kumagai on 2020/11/13.
//

import Foundation

public struct TasksError: Error, CustomStringConvertible {
    public let message: String

    public var description: String {
        message
    }
}
