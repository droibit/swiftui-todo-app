//
//  TasksComponent.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/19.
//

import Core
import Foundation
import NeedleFoundation

protocol TasksDependency: Dependency {
    var tasksRepository: TasksRepository { get }
    var schedulers: SchedulerProvider { get }
}

class TasksComponent: Component<TasksDependency>, ObservableObject {
    private var viewModel: TasksViewModel {
        shared {
            TasksViewModel(
                tasksRepository: dependency.tasksRepository,
                schedulers: dependency.schedulers
            )
        }
    }

    func makeView() -> TasksView {
        TasksView(viewModel: viewModel)
    }
}

extension TasksComponent {
    static func make() -> TasksComponent {
        AppComponent.instance.tasks
    }
}
