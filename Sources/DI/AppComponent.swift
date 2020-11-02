//
//  AppComponent.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/01.
//

import GRDB
import Foundation
import NeedleFoundation

class AppComponent: BootstrapComponent {
    static var instance: AppComponent = .init()
}

// MARK: - Repository

extension AppComponent {
    var localtasksDataSource: TasksDataSource {
        shared {
            let dbPath = getDocumentsDirectory().appendingPathComponent("Tasks.db")
            return LocalTasksDataSource(
                databaseQueue: try! DatabaseQueue(path: dbPath.absoluteString)
            )
        }
    }
}

private func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    return documentsDirectory
}
