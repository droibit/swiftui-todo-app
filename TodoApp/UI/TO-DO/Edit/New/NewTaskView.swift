//
//  NewTaskView.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/29.
//

import SwiftUI

struct NewTaskView: View {
    @StateObject private var component = NewTaskComponent.make()

    var body: some View {
        component.makeContentView()
    }
}

struct NewTaskContentView: View {
    @Environment(\.presentationMode) private var presentationMode

    @ObservedObject var viewModel: NewTaskViewModel

    var body: some View {
        EditTaskNavigationView(
            title: L10n.NewTask.title,
            doneAction: doneAction
        ) {
            EditTaskView(
                title: $viewModel.title,
                description: $viewModel.description
            )
            .onReceive(viewModel.$makeTaskResult, perform: self.didReceiveResult)
        }
    }

    private var doneAction: DoneEditTaskAction {
        DoneEditTaskAction(
            isEnabled: viewModel.isInputCompleted,
            handler: viewModel.makeTask
        )
    }

    private func didReceiveResult(_ result: MakeTaskResult) {
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
