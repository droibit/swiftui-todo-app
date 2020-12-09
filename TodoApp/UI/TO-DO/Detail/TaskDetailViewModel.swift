//
//  TaskDetailViewModel.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/12/01.
//

import Combine
import Core
import Foundation
import RxRelay
import RxSwift

class TaskDetailViewModel: ObservableObject {
    private let tasksRepository: TasksRepository

    private let schedulers: SchedulerProvider

    private var universalBag: UniversalDisposeBag!

    @Published private(set) var task: Task

    @Published private(set) var deleteTaskResult: DeleteTaskResult

    @Published private(set) var toggleTaskCompletedResult: ToggleTaskCompletedResult

    init(tasksRepository: TasksRepository,
         schedulers: SchedulerProvider,
         initialTask task: Task,
         deleteTaskResult: DeleteTaskResult = .none,
         toggleTaskCompletedResult: ToggleTaskCompletedResult = .none)
    {
        self.tasksRepository = tasksRepository
        self.schedulers = schedulers
        self.task = task
        self.deleteTaskResult = deleteTaskResult
        self.toggleTaskCompletedResult = toggleTaskCompletedResult
    }

    func onAppear() {
        guard universalBag == nil else {
            return
        }
        universalBag = UniversalDisposeBag()

        subscribeTask()
    }

    private func subscribeTask() {
        tasksRepository.tasks
            .compactMap { [unowned self] tasks in tasks.first(where: { $0.id == self.task.id }) }
            .filter { [unowned self] task in self.task != task }
            .observeOn(schedulers.main)
            .subscribe(onNext: { [unowned self] task in
                self.task = task
            }, onError: { error in
                // TODO: Improve error handling.
                let actualError = error as! TasksError
                print("Error: \(actualError)")
            }).disposed(by: universalBag.dispose)
    }

    func toggleTaskCompleted() {
        if toggleTaskCompletedResult.isInProgress {
            return
        }
        toggleTaskCompletedResult = .inProgress

        tasksRepository.getTask(taskId: task.id)
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

        tasksRepository.deleteTask(taskId: task.id)
            .observeOn(schedulers.main)
            .subscribe(onCompleted: { [unowned self] in
                self.deleteTaskResult = .success
            }, onError: { [unowned self] error in
                let actualError = error as! TasksError
                self.deleteTaskResult = .error(message: actualError.message)
            }).disposed(by: universalBag.dispose)
    }
}
