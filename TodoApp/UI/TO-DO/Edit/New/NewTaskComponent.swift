//
//  NewTaskComponent.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/30.
//

import Core
import Foundation
import NeedleFoundation

protocol NewTaskDependency: Dependency {
    var tasksRepository: TasksRepository { get }
    var schedulers: SchedulerProvider { get }
}

class NewTaskComponent: Component<NewTaskDependency>, ObservableObject {
    private var viewModel: NewTaskViewModel {
        shared {
            NewTaskViewModel(
                tasksRepository: dependency.tasksRepository,
                schedulers: dependency.schedulers
            )
        }
    }

    func makeContentView() -> NewTaskContentView {
        NewTaskContentView(viewModel: viewModel)
    }
}

extension NewTaskComponent {
    static func make() -> NewTaskComponent {
        AppComponent.instance.newTask
    }
}
