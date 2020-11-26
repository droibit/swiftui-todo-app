//
//  TaskEntity.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/02.
//

import Foundation
import GRDB

// struct TaskEntity: Equatable {
//    let id: String
//    let title: String
//    let description: String
//    let isCompleted: Bool
//    let createdAtMillis: Int
// }
//
typealias TaskEntity = Task

extension TaskEntity: FetchableRecord, MutablePersistableRecord {
    public static var databaseTableName: String {
        "tasks"
    }

    enum Columns {
        static let id = Column("id")
        static let title = Column("title")
        static let description = Column("description")
        static let completed = Column("isCompleted")
        static let createdAt = Column("createdAt")
    }
}
