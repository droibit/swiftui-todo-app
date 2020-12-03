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
    private let tasks: [Task]
    private let tasksFilter: Binding<TasksFilter>
    private let tasksSorting: Binding<TasksSorting>

    init(tasks: [Task],
         tasksFilter: Binding<TasksFilter>,
         tasksSorting: Binding<TasksSorting>)
    {
        self.tasks = tasks
        self.tasksFilter = tasksFilter
        self.tasksSorting = tasksSorting
    }

    var body: some View {
        VStack(spacing: 0) {
            TasksHeader(
                filter: tasksFilter,
                sorting: tasksSorting
            )
            if tasks.isEmpty {
                EmptyTasksView()
            } else {
                taskListView()
            }
        }
    }

    private func taskListView() -> some View {
        List {
            ForEach(tasks) { task in
                NavigationLink(destination: DetailTaskView(task: task)) {
                    TaskItemView(task: task)
                }
            }.onDelete { indexSet in
                print("delete at: \(indexSet)")
            }
        }
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
        }.frame(maxHeight: .infinity)
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
                tasks: [
                    Task(title: "Task1Task1Task1Task1Task1Task1Task1Task1Task1Task1Task1", description: ""),
                    Task(title: "Task2", description: "description"),
                    Task(title: "Task3", description: ""),
                    Task(title: "Task4", description: ""),
                ],
                tasksFilter: .constant(.all),
                tasksSorting: .constant(.title(order: .asc))
            )

            TaskListView(
                tasks: [],
                tasksFilter: .constant(.completed),
                tasksSorting: .constant(.createdDate(order: .asc))
            )

            TasksErrorView(message: "Failed to get tasks.")
        }
    }
}
