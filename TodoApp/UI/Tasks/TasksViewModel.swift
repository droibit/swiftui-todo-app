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

    private var universalBag = UniversalDisposeBag()

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
        ) { [unowned self] tasks, filter, sorting in
            self.convert(sourceTasks: tasks, filter: filter, sorting: sorting)
        }.observeOn(schedulers.main)
            .subscribe(onNext: { [unowned self] tasks in
                self.getTasksResult = .success(tasks: tasks)
            }, onError: { [unowned self] error in
                let actualError = error as! TasksError
                self.getTasksResult = .error(message: actualError.message)
            }).disposed(by: universalBag.dispose)
    }

    private func convert(sourceTasks: [Task], filter: TasksFilter, sorting: TasksSorting) -> [Task] {
        sourceTasks.filter { task in
            switch filter {
            case .all:
                return true
            case .active:
                return task.isActive
            case .completed:
                return task.isCompleted
            }
        }.sorted(by: { lhs, rhs in
            switch sorting {
            case let .title(order):
                return (order == .asc)
                    ? lhs.title.lowercased() < rhs.title.lowercased()
                    : rhs.title.lowercased() < lhs.title.lowercased()
            case let .createdDate(order):
                return (order == .asc)
                    ? lhs.createdAt < rhs.createdAt
                    : rhs.createdAt < lhs.createdAt
            }
        })
    }
}
