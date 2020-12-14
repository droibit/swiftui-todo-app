//
//  TaskDetailView.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/12/01.
//

import Core
import SwiftUI

struct TaskDetailView: View {
    @ObservedObject var viewModel: TaskDetailViewModel

    @Environment(\.presentationMode) private var presentationMode

    @State private var currentTask: Task?

    var body: some View {
        TaskDetailView.Navigation(onEdit: onEdit) {
            TaskDetailUiStateView(
                uiState: viewModel.uiState,
                onToggleCompleted: viewModel.toggleTaskCompleted,
                onDelete: viewModel.deleteTask
            )
            .onReceive(viewModel.$deleteTaskResult, perform: self.onReceiveResult)
            .onReceive(viewModel.$toggleTaskCompletedResult, perform: self.onReceiveResult)
            .onAppear(perform: viewModel.onAppear)
        }
        .sheet(item: $currentTask) { task in
            UpdateTaskView.Builder(task: task)
        }
    }

    private func onEdit() {
        currentTask = viewModel.uiState.task
    }

    private func onReceiveResult(result: ToggleTaskCompletedResult) {
        guard case .error = result else {
            return
        }
        presentationMode.wrappedValue.dismiss()
    }

    private func onReceiveResult(_ result: DeleteTaskResult) {
        switch result {
        case .inProgress:
            // TODO: Show progress.
            break
        case .success, .error:
            presentationMode.wrappedValue.dismiss()
        case .none:
            break
        }
    }
}

// MARK: - Builder

extension TaskDetailView {
    struct Builder: View {
        @StateObject private var component = TaskDetailComponent.make()

        let initialTask: Task

        init(task: Task) {
            initialTask = task
        }

        var body: some View {
            component.makeView(initialTask: initialTask)
        }
    }
}

// MARK: - Navigation

private extension TaskDetailView {
    struct Navigation<Content>: View where Content: View {
        private let onEdit: () -> Void
        private let content: Content

        init(onEdit: @escaping () -> Void = {},
             @ViewBuilder content: () -> Content)
        {
            self.onEdit = onEdit
            self.content = content()
        }

        var body: some View {
            content
                .navigationBarTitle(Text(L10n.DetailTask.title), displayMode: .inline)
                .navigationBarItems(trailing: Button(L10n.Common.edit, action: onEdit))
        }
    }
}

// MARK: - Preview

struct TaskDetailContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TaskDetailView.Navigation {
                Text("Dummy")
            }
        }
    }
}
