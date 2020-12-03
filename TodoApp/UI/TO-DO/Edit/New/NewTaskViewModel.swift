//
//  NewTaskViewModel.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/30.
//

import Combine
import Core
import Foundation
import RxSwift

class NewTaskViewModel: ObservableObject {
    private let tasksRepository: TasksRepository

    private let schedulers: SchedulerProvider

    private let disposeBag = DisposeBag()

    @Published var title: String = ""

    @Published var description: String = ""

    @Published private(set) var makeTaskResult: MakeTaskResult

    var isInputCompleted: Bool {
        !title.isEmpty
    }

    init(
        tasksRepository: TasksRepository,
        schedulers: SchedulerProvider,
        makeTaskResult: MakeTaskResult = .none
    ) {
        self.tasksRepository = tasksRepository
        self.schedulers = schedulers
        self.makeTaskResult = makeTaskResult
    }

    deinit {
        print("deinit: \(type(of: self))")
    }

    func makeTask() {
        if makeTaskResult.isInProgress {
            return
        }
        makeTaskResult = .inProgress

        tasksRepository.createTask(
            title: title,
            description: description
        )
        .observeOn(schedulers.main)
        .subscribe(onCompleted: { [unowned self] in
            self.makeTaskResult = .success
        }, onError: { error in
            let actualError = error as! TasksError
            self.makeTaskResult = .error(message: actualError.message)
        }).disposed(by: disposeBag)
    }
}
