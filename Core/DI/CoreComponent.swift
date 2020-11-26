//
//  CoreComponent.swift
//  Core
//
//  Created by Shinya Kumagai on 2020/11/26.
//

import Foundation
import GRDB
import NeedleFoundation
import RxRelay
import RxSwift

public class CoreComponent: BootstrapComponent {}

// MARK: - Utils

public extension CoreComponent {
    var schedulers: SchedulerProvider {
        shared {
            SchedulerProvider(
                main: MainScheduler.instance,
                background: ConcurrentDispatchQueueScheduler(qos: .userInitiated),
                current: CurrentThreadScheduler.instance
            )
        }
    }
}

// MARK: - Repository

extension CoreComponent {
    public var tasksRepository: TasksRepository {
        shared {
            TasksRepositoryImpl(
                localDataSource: localTasksDataSource,
                schedulers: schedulers
            )
        }
    }

    var localTasksDataSource: TasksDataSource {
        shared {
            // TODO: Persist in storage
            //            let dbPath = getDocumentsDirectory().appendingPathComponent("Tasks.db")
            LocalTasksDataSource(
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
