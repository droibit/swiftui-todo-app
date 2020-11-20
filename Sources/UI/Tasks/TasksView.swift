//
//  TasksView.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/15.
//

import SwiftUI

struct TasksView: View {
    @StateObject private var component: TasksComponent = .make()

    var body: some View {
        component.makeView()
    }
}

struct TasksContentView: View {
    @ObservedObject
    var viewModel: TasksViewModel

    var body: some View {
        NavigationView {
            Group {
                switch viewModel.uiStateResult {
                case .inProgress:
                    InProgressView()
                case let .success(uiState):
                    TaskListView(uiState: uiState)
                case let .error(message):
                    TasksErrorView(message: message)
                }
            }
            .navigationBarTitle(Text(L10n.Tasks.title), displayMode: .inline)
            .navigationBarItems(leading: Button(action: {}, label: {
                Image(systemName: "gear")
            }), trailing: Button(action: {}, label: {
                Image(systemName: "plus")
            }))
            .onAppear(perform: viewModel.onAppear)
        }
    }
}

// struct TasksContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        TasksContentView()
//    }
// }
