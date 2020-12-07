//
//  UpdateTaskViewModel.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/12/07.
//

import Combine
import Core
import Foundation
import RxSwift

class UpdateTaskViewModel: ObservableObject {
    private let tasksRepository: TasksRepository

    private let schedulers: SchedulerProvider

    private let taskId: String

    private let disposeBag = DisposeBag()

    @Published var title: String

    @Published var description: String

    @Published private(set) var updateTaskResult: UpdateTaskResult

    var isInputCompleted: Bool {
        !title.isEmpty
    }

    init(
        tasksRepository: TasksRepository,
        schedulers: SchedulerProvider,
        initialTask task: Task,
        updateTaskResult: UpdateTaskResult = .none
    ) {
        self.tasksRepository = tasksRepository
        self.schedulers = schedulers
        taskId = task.id
        title = task.title
        description = task.description
        self.updateTaskResult = updateTaskResult
    }

    deinit {
        print("deinit: \(type(of: self))")
    }

    func updateTask() {
        if updateTaskResult.isInProgress {
            return
        }
        updateTaskResult = .inProgress

        tasksRepository.updateTask(
            taskId: taskId,
            title: title,
            description: description
        )
        .observeOn(schedulers.main)
        .subscribe(onCompleted: { [unowned self] in
            self.updateTaskResult = .success
        }, onError: { [unowned self] error in
            self.updateTaskResult = UpdateTaskResult(error: error)
        }).disposed(by: disposeBag)
    }
}
