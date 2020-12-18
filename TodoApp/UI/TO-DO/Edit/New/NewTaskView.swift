//
//  NewTaskView.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/29.
//

import SwiftUI

struct NewTaskView: View {
    @ObservedObject var viewModel: NewTaskViewModel

    @Environment(\.presentationMode) private var presentationMode

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
        .accentColor(Color(Asset.Colors.accentColor.color))
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

// MARK: - Builder

extension NewTaskView {
    struct Builder: View {
        @StateObject private var component = NewTaskComponent.make()

        var body: some View {
            component.makeView()
        }
    }
}
