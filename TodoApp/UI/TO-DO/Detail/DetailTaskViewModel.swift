//
//  DetailTaskViewModel.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/12/01.
//

import Combine
import Core
import Foundation
import RxRelay
import RxSwift

class DetailTaskViewModel: ObservableObject {
    private let tasksRepository: TasksRepository

    private let schedulers: SchedulerProvider

    private let taskId: String

    private var universalBag: UniversalDisposeBag!

    @Published private(set) var getTaskResult: GetTaskResult

    @Published private(set) var deleteTaskResult: DeleteTaskResult

    @Published private(set) var toggleTaskCompletedResult: ToggleTaskCompletedResult

    init(tasksRepository: TasksRepository,
         schedulers: SchedulerProvider,
         initailTask task: Task,
         deleteTaskResult: DeleteTaskResult = .none,
         toggleTaskCompletedResult: ToggleTaskCompletedResult = .none)
    {
        self.tasksRepository = tasksRepository
        self.schedulers = schedulers
        taskId = task.id
        getTaskResult = .success(task: task)
        self.deleteTaskResult = deleteTaskResult
        self.toggleTaskCompletedResult = toggleTaskCompletedResult
    }

    func onAppear() {
        guard universalBag == nil else {
            return
        }
        universalBag = UniversalDisposeBag()

        subscribeTask(by: taskId)
    }

    private func subscribeTask(by taskId: String) {
        tasksRepository.tasks
            .map { tasks in tasks.first(where: { $0.id == taskId }) }
            .observeOn(schedulers.main)
            .subscribe(onNext: { [unowned self] task in
                if let task = task {
                    self.getTaskResult = .success(task: task)
                }
            }, onError: { [unowned self] error in
                let actualError = error as! TasksError
                self.getTaskResult = .error(message: actualError.message)
            }).disposed(by: universalBag.dispose)
    }

    func toggleTaskCompleted() {
        if toggleTaskCompletedResult.isInProgress {
            return
        }
        toggleTaskCompletedResult = .inProgress

        tasksRepository.getTask(taskId: taskId)
            .flatMapCompletable { task in
                if task.isCompleted {
                    return self.tasksRepository.activateTask(taskId: task.id)
                } else {
                    return self.tasksRepository.completeTask(taskId: task.id)
                }
            }
            .observeOn(schedulers.main)
            .subscribe(onCompleted: { [unowned self] in
                self.toggleTaskCompletedResult = .success
            }, onError: { [unowned self] error in
                let actualError = error as! TasksError
                self.toggleTaskCompletedResult = .error(message: actualError.message)
            }).disposed(by: universalBag.dispose)
    }

    func deleteTask() {
        if deleteTaskResult.isInProgress {
            return
        }
        deleteTaskResult = .inProgress

        tasksRepository.deleteTask(taskId: taskId)
            .observeOn(schedulers.main)
            .subscribe(onCompleted: { [unowned self] in
                self.deleteTaskResult = .success
            }, onError: { [unowned self] error in
                let actualError = error as! TasksError
                self.deleteTaskResult = .error(message: actualError.message)
            }).disposed(by: universalBag.dispose)
    }
}
