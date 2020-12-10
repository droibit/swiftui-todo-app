//
//  TasksView.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/15.
//

import SwiftUI

struct TasksView: View {
    @ObservedObject var viewModel: TasksViewModel

    var body: some View {
        TasksView.Navigation {
            Group {
                switch viewModel.getTasksResult {
                case .inProgress:
                    InProgressView()
                case let .success(tasks):
                    TaskListView(
                        tasks: tasks,
                        tasksFilter: $viewModel.tasksFilter,
                        tasksSorting: $viewModel.tasksSorting
                    )
                case let .error(message):
                    TaskErrorView(message: message)
                }
            }
            .onAppear(perform: viewModel.onAppear)
        }
    }
}

// MRK: - Builder

extension TasksView {
    struct Builder: View {
        @StateObject private var component = TasksComponent.make()

        var body: some View {
            component.makeView()
        }
    }
}

// MARK: - Navigation

private extension TasksView {
    struct Navigation<Content>: View where Content: View {
        private let content: Content

        @State private var presentsNewTask: Bool = false

        init(@ViewBuilder content: () -> Content) {
            self.content = content()
        }

        var body: some View {
            NavigationView {
                content
                    .navigationBarTitle(Text(L10n.Tasks.title), displayMode: .inline)
                    .navigationBarItems(trailing: Button(action: {
                        presentsNewTask = true
                    }, label: {
                        Image(systemName: "plus")
                    }))
                    .sheet(isPresented: $presentsNewTask, content: NewTaskView.Builder.init)
            }
        }
    }
}

struct TasksNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView.Navigation {
            Text("Dummy")
        }
    }
}
