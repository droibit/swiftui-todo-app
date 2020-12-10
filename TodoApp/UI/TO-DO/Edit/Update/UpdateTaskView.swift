//
//  UpdateTaskView.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/12/07.
//

import Core
import SwiftUI

struct UpdateTaskView: View {
    @Environment(\.presentationMode) private var presentationMode

    @ObservedObject var viewModel: UpdateTaskViewModel

    var body: some View {
        EditTaskNavigationView(
            title: L10n.UpdateTask.title,
            doneAction: doneAction
        ) {
            EditTaskView(
                title: $viewModel.title,
                description: $viewModel.description
            )
            .onReceive(viewModel.$updateTaskResult, perform: self.didReceiveResult)
        }
    }

    private var doneAction: DoneEditTaskAction {
        DoneEditTaskAction(
            isEnabled: viewModel.isInputCompleted,
            handler: viewModel.updateTask
        )
    }

    private func didReceiveResult(_ result: UpdateTaskResult) {
        switch result {
        case .success:
            presentationMode.wrappedValue.dismiss()
        case let .error(message):
            // TODO: Present error HUD
            print(message)
        default:
            break
        }
    }
}

// MARK: - Builder

extension UpdateTaskView {
    struct Builder: View {
        @StateObject private var component = UpdateTaskComponent.make()

        let initialTask: Task

        init(task: Task) {
            initialTask = task
        }

        var body: some View {
            component.makeContentView(initialTask: initialTask)
        }
    }
}
