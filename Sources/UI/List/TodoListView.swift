//
//  TodoListView.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/15.
//

import SwiftUI

struct TodoListView: View {
    var body: some View {
        Text(L10n.TodoList.title)
            .tabItem {
                Image(systemName: "list.bullet")
                Text(L10n.TodoList.title)
            }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
    }
}
