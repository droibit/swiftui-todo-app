//
//  Task.swift
//  Core
//
//  Created by Shinya Kumagai on 2020/11/01.
//

import Foundation

public struct Task: Equatable, Codable, Identifiable {
    public let id: String
    public let title: String
    public let description: String
    public let isCompleted: Bool
    public let createdAt: Date

    public init(id: String, title: String, description: String, isCompleted: Bool, createdAt: Date) {
        self.id = id
        self.title = title
        self.description = description
        self.isCompleted = isCompleted
        self.createdAt = createdAt
    }

    public var isActive: Bool {
        !isCompleted
    }

    public var isEmpty: Bool {
        title.isEmpty || description.isEmpty
    }
}

public extension Task {
    init(title: String, description: String) {
        self.init(id: UUID().uuidString, title: title, description: description, isCompleted: false, createdAt: Date())
    }
}
