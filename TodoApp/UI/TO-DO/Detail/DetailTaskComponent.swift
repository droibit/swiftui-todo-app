//
//  DetailTaskComponent.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/12/03.
//

import Core
import Foundation
import NeedleFoundation

protocol DetailTaskDependency: Dependency {
    var tasksRepository: TasksRepository { get }
    var schedulers: SchedulerProvider { get }
}

class DetailTaskComponent: Component<DetailTaskDependency>, ObservableObject {
    func makeContentView(initialTask: Task) -> DetailTaskContentView {
        DetailTaskContentView(viewModel: viewModel(with: initialTask))
    }

    private func viewModel(with task: Task) -> DetailTaskViewModel {
        shared {
            DetailTaskViewModel(
                tasksRepository: dependency.tasksRepository,
                schedulers: dependency.schedulers,
                initialTask: task
            )
        }
    }
}

extension DetailTaskComponent {
    static func make() -> DetailTaskComponent {
        AppComponent.instance.detailTask
    }
}
