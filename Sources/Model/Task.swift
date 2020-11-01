//
//  Task.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/01.
//

import Foundation

struct Task: Equatable {
    let id: UUID
    let title: String
    let description: String
    let isCompleted: Bool
}

extension Task {
    init(title: String, description: String) {
        self.init(id: UUID(), title: title, description: description, isCompleted: false)
    }
}
