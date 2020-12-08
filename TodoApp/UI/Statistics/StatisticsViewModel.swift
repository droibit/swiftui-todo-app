//
//  StatisticsViewModel.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/12/09.
//

import Combine
import Core
import Foundation
import RxRelay
import RxSwift

class StatisticsViewModel: ObservableObject {
    private let tasksRepository: TasksRepository

    private let schedulers: SchedulerProvider

    private let disposeBag = DisposeBag()

    @Published private(set) var getStatisticsResult: GetStatisticsResult

    init(tasksRepository: TasksRepository,
         schedulers: SchedulerProvider,
         getStatisticsResult: GetStatisticsResult = .inProgress(initial: true))
    {
        self.tasksRepository = tasksRepository
        self.schedulers = schedulers
        self.getStatisticsResult = getStatisticsResult
    }

    deinit {
        print("deinit: \(type(of: self))")
    }

    func onAppear() {
        guard case let .inProgress(initial) = getStatisticsResult, initial else {
            return
        }
        getStatisticsResult = .inProgress(initial: false)

        tasksRepository.tasks
            .map {
                StatisticsUiState(
                    activeTaskCount: $0.filter(\.isActive).count,
                    completedTaskCount: $0.filter(\.isCompleted).count
                )
            }
            .observeOn(schedulers.main)
            .subscribe(onNext: { [unowned self] uiState in
                self.getStatisticsResult = .success(uiState: uiState)
            }, onError: { [unowned self] error in
                self.getStatisticsResult = GetStatisticsResult(error: error)
            }).disposed(by: disposeBag)
    }
}
