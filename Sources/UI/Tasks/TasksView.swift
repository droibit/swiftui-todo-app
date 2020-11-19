//
//  TasksView.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/15.
//

import SwiftUI

struct TasksView: View {
    var body: some View {
        NavigationView {
            Text("TODO")
                .navigationBarTitle(Text(L10n.Tasks.title), displayMode: .inline)
                .navigationBarItems(leading: Button(action: {}, label: {
                    Image(systemName: "gear")
                }), trailing: Button(action: {}, label: {
                    Image(systemName: "plus")
                }))
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}

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
