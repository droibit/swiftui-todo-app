//
//  NewTaskView.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/29.
//

import SwiftUI

struct NewTaskView: View {
//    @Environment(\.presentationMode) private var presentationMode

    // TODO: Move to ViewModel
    @State private var title: String = ""
    @State private var description: String = ""

    var body: some View {
        NewTaskNavigationView {
            EditTaskView(
                title: $title,
                description: $description
            )
        }
    }
}

private struct NewTaskNavigationView<Content>: View where Content: View {
    private let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        NavigationView {
            content
                .navigationBarTitle(Text(L10n.NewTask.title), displayMode: .inline)
                .navigationBarItems(trailing: Button(L10n.EditTask.done) {})
        }
    }
}

// swiftlint:disable type_name
struct NewTaskNavigationView_Preview: PreviewProvider {
    static var previews: some View {
        NewTaskNavigationView {
            Text("Dummy")
        }
    }
}
