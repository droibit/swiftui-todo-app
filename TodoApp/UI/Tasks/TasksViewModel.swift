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

    private let disposeBag = DisposeBag()

    private var cancellabBag = Set<AnyCancellable>()

    @Published var tasksFilter: TasksFilter = .all

    @Published var tasksSorting: TasksSorting = .createdDate(order: .asc)

    @Published private(set) var uiStateResult: TasksUiStateResult

    init(tasksRepository: TasksRepository,
         schedulers: SchedulerProvider,
         uiStateResult: TasksUiStateResult = .inProgress(initial: true))
    {
        self.tasksRepository = tasksRepository
        self.schedulers = schedulers
        self.uiStateResult = uiStateResult
    }

    deinit {
        print("deinit: \(type(of: self))")
    }

    func onAppear() {
        guard case let .inProgress(initial) = uiStateResult, initial else {
            return
        }
        uiStateResult = .inProgress(initial: false)

        let tasksFilterSink: Observable<TasksFilter> = {
            let sink = BehaviorRelay<TasksFilter>(value: tasksFilter)
            $tasksFilter.sink { sink.accept($0) }
                .store(in: &cancellabBag)
            return sink.asObservable()
        }()

        let tasksSortingSink: Observable<TasksSorting> = {
            let sink = BehaviorRelay<TasksSorting>(value: tasksSorting)
            $tasksSorting.sink { sink.accept($0) }
                .store(in: &cancellabBag)
            return sink.asObservable()
        }()

        Observable.combineLatest(
            tasksRepository.tasks,
            tasksFilterSink,
            tasksSortingSink
        ) { tasks, filter, sorting in
            TasksUiState(sourceTasks: tasks, filter: filter, sorting: sorting)
        }.observeOn(schedulers.main)
            .subscribe(onNext: { [unowned self] uiState in
                self.uiStateResult = .success(uiState: uiState)
            }, onError: { [unowned self] error in
                let actualError = error as! TasksError
                self.uiStateResult = .error(message: actualError.message)
            }).disposed(by: disposeBag)
    }
}
