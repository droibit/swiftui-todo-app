//
//  StatisticsComponent.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/12/09.
//

import Combine
import Core
import NeedleFoundation

protocol StatisticsDependency: Dependency {
    var tasksRepository: TasksRepository { get }
    var schedulers: SchedulerProvider { get }
}

class StatisticsComponent: Component<StatisticsDependency>, ObservableObject {
    private var viewModel: StatisticsViewModel {
        shared {
            StatisticsViewModel(
                tasksRepository: dependency.tasksRepository,
                schedulers: dependency.schedulers
            )
        }
    }

    func makeView() -> StatisticsView {
        StatisticsView(viewModel: viewModel)
    }
}

extension StatisticsComponent {
    static func make() -> StatisticsComponent {
        AppComponent.instance.statistics
    }
}
