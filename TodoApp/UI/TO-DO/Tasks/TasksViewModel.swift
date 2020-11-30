//
//  TasksViewModel.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/19.
//

import Combine
import Core
import Foundation
import RxRelay
import RxSwift

class TasksViewModel: ObservableObject {
    private let tasksRepository: TasksRepository

    private let schedulers: SchedulerProvider

    private let universalBag = UniversalDisposeBag()

    @Published var tasksFilter: TasksFilter = .all

    @Published var tasksSorting: TasksSorting = .createdDate(order: .asc)

    @Published private(set) var getTasksResult: GetTasksResult

    init(tasksRepository: TasksRepository,
         schedulers: SchedulerProvider,
         getTasksResult: GetTasksResult = .inProgress(initial: true))
    {
        self.tasksRepository = tasksRepository
        self.schedulers = schedulers
        self.getTasksResult = getTasksResult
    }

    deinit {
        print("deinit: \(type(of: self))")
    }

    func onAppear() {
        guard case let .inProgress(initial) = getTasksResult, initial else {
            return
        }
        getTasksResult = .inProgress(initial: false)

        let tasksFilterSink = BehaviorRelay(value: tasksFilter)
            .bind(to: $tasksFilter, storeIn: &universalBag.cancellables)

        let tasksSortingSink = BehaviorRelay(value: tasksSorting)
            .bind(to: $tasksSorting, storeIn: &universalBag.cancellables)

        Observable.combineLatest(
            tasksRepository.tasks,
            tasksFilterSink,
            tasksSortingSink
        ) { sourceTasks, filter, sorting in
            sourceTasks
                .filter(by: filter)
                .sorted(by: sorting)
        }.observeOn(schedulers.main)
            .subscribe(onNext: { [unowned self] tasks in
                self.getTasksResult = .success(tasks: tasks)
            }, onError: { [unowned self] error in
                let actualError = error as! TasksError
                self.getTasksResult = .error(message: actualError.message)
            }).disposed(by: universalBag.dispose)
    }
}
