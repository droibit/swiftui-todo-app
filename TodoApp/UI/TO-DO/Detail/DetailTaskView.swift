//
//  DetailTaskView.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/12/01.
//

import Core
import SwiftUI

struct DetailTaskView: View {
    @StateObject private var component = DetailTaskComponent.make()

    let initialTask: Task

    init(task: Task) {
        initialTask = task
    }

    var body: some View {
        component.makeContentView(initialTask: initialTask)
    }
}

struct DetailTaskContentView: View {
//    @Environment(\.presentationMode) private var presentationMode

    @ObservedObject var viewModel: DetailTaskViewModel

    var body: some View {
        DetailTaskNavigation {
            Text("Hello, World!")
                .navigationBarTitle(Text(L10n.DetailTask.title), displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {}, label: {
                    Image(systemName: "trash")
                }))
        }
    }
}

private struct DetailTaskNavigation<Content>: View where Content: View {
    private let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .navigationBarTitle(Text(L10n.DetailTask.title), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {}, label: {
                Image(systemName: "trash")
            }))
    }
}

struct DetailTaskNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailTaskNavigation {
                Text("Dummy")
            }
        }
    }
}
