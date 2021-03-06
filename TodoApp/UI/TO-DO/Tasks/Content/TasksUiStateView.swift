//
//  TasksUiStateView.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/19.
//

import Core
import SwiftUI

// MARK: - ListView

struct TaskListView: View {
    private var tasks: [Task]
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
        List(tasks) { task in
            NavigationLink(destination: TaskDetailView.Builder(task: task)) {
                TaskItemView(task: task)
            }
        }
    }
}

// MARK: - EmptyView

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

// MARK: - Previews

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
        }
    }
}
