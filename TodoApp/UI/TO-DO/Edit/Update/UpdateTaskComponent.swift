//
//  UpdateTaskComponent.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/12/07.
//

import Core
import Foundation
import NeedleFoundation

protocol UpdateTaskDependency: Dependency {
    var tasksRepository: TasksRepository { get }
    var schedulers: SchedulerProvider { get }
}

class UpdateTaskComponent: Component<UpdateTaskDependency>, ObservableObject {
    func makeContentView(initialTask task: Task) -> UpdateTaskView {
        UpdateTaskView(viewModel: viewModel(with: task))
    }

    private func viewModel(with task: Task) -> UpdateTaskViewModel {
        shared {
            UpdateTaskViewModel(
                tasksRepository: dependency.tasksRepository,
                schedulers: dependency.schedulers,
                initialTask: task
            )
        }
    }
}

extension UpdateTaskComponent {
    static func make() -> UpdateTaskComponent {
        AppComponent.instance.updateTask
    }
}
