//
//  DetailTaskComponent.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/12/03.
//

import Core
import Foundation
import NeedleFoundation

protocol TaskDetailDependency: Dependency {
    var tasksRepository: TasksRepository { get }
    var schedulers: SchedulerProvider { get }
}

class TaskDetailComponent: Component<TaskDetailDependency>, ObservableObject {
    func makeView(initialTask: Task) -> TaskDetailView {
        TaskDetailView(viewModel: viewModel(with: initialTask))
    }

    private func viewModel(with task: Task) -> TaskDetailViewModel {
        shared {
            TaskDetailViewModel(
                tasksRepository: dependency.tasksRepository,
                schedulers: dependency.schedulers,
                initialTask: task
            )
        }
    }
}

extension TaskDetailComponent {
    static func make() -> TaskDetailComponent {
        AppComponent.instance.taskDetail
    }
}
