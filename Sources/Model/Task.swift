//
//  Task.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/01.
//

import Foundation

struct Task: Equatable, Codable {
    let id: String
    let title: String
    let description: String
    let isCompleted: Bool
    let createdAt: Date
    
    var isActive: Bool {
        !isCompleted
    }
    
    var isEmpty: Bool {
        title.isEmpty || description.isEmpty
    }
}

extension Task {
    init(title: String, description: String) {
        self.init(id: UUID().uuidString, title: title, description: description, isCompleted: false, createdAt: Date())
    }
}
