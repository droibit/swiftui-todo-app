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
            Text(L10n.Tasks.title)
                .navigationBarTitle(Text(L10n.Tasks.title), displayMode: .inline)
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}
