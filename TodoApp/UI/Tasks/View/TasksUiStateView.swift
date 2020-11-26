//
//  TasksUiStateView.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/19.
//

import Core
import SwiftUI

// MARK: - TaskListView

struct TaskListView: View {
    let uiState: TasksUiState

    var body: some View {
        if uiState.tasks.isEmpty {
            EmptyTasksView()
        } else {
            taskListView()
        }
    }

    private func taskListView() -> some View {
        List {
            Section(
                header: TasksHeader(
                    filter: uiState.filter,
                    sorting: uiState.sorting
                )
            ) {
                ForEach(uiState.tasks) { task in
                    TaskItemView(task: task)
                }.onDelete { indexSet in
                    print("delete at: \(indexSet)")
                }
            }
        }.listStyle(GroupedListStyle())
    }
}

private struct EmptyTasksView: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "sun.max")
                .font(Font.system(size: 40))
                .foregroundColor(Color(Asset.Colors.accentColor.color))

            Text(L10n.Tasks.noTasks)
                .font(Font.subheadline.weight(.regular))
        }
    }
}

// MARK: - TasksErrorView

struct TasksErrorView: View {
    let message: String
    // TODO: Retry to get tasks.
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.circle")
                .font(Font.system(size: 40))

            Text(message)
                .font(Font.subheadline.weight(.regular))
                .padding(.horizontal)
        }
    }
}

// MARK: - Preview

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TaskListView(
                uiState: TasksUiState(
                    sourceTasks: [
                        Task(title: "Task1Task1Task1Task1Task1Task1Task1Task1Task1Task1Task1", description: ""),
                        Task(title: "Task2", description: "description"),
                        Task(title: "Task3", description: ""),
                        Task(title: "Task4", description: ""),
                    ],
                    filter: .completed,
                    sorting: .createdDate(order: .asc)
                )
            )

            TaskListView(
                uiState: TasksUiState(
                    sourceTasks: [],
                    filter: .completed,
                    sorting: .createdDate(order: .asc)
                )
            )

            TasksErrorView(message: "Failed to get tasks.")
        }
    }
}
