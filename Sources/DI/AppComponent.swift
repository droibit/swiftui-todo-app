//
//  AppComponent.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/01.
//

import GRDB
import Foundation
import NeedleFoundation
import RxSwift
import RxRelay

class AppComponent: BootstrapComponent {
    static var instance: AppComponent = .init()
}

// MARK: - Repository

extension AppComponent {
    var schedulers: SchedulerProvider {
        shared {
            SchedulerProvider(
                main: MainScheduler.instance,
                background: ConcurrentDispatchQueueScheduler(qos: .userInitiated),
                current: CurrentThreadScheduler.instance
            )
        }
    }
    
    var localtasksDataSource: TasksDataSource {
        shared {
//            let dbPath = getDocumentsDirectory().appendingPathComponent("Tasks.db")
            return LocalTasksDataSource(
//                databaseQueue: try! DatabaseQueue(path: dbPath.absoluteString),
                databaseQueue: DatabaseQueue(),
                schedulers: schedulers,
                reloadEventSink: PublishRelay()
            )
        }
    }
}

private func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    return documentsDirectory
}
