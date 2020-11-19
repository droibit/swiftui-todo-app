//
//  TaskListView.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/19.
//

import SwiftUI

struct TaskListView: View {
    let uiState: TasksUiState

    var body: some View {
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

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
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
    }
}
