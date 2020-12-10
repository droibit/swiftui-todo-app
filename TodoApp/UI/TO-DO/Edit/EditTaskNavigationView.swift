//
//  EditTaskNavigationView.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/12/07.
//

import SwiftUI

struct DoneEditTaskAction {
    let isEnabled: Bool
    fileprivate let handler: () -> Void

    init(isEnabled: Bool, handler: @escaping () -> Void) {
        self.isEnabled = isEnabled
        self.handler = handler
    }
}

struct EditTaskNavigationView<Content>: View where Content: View {
    private let content: Content

    private let title: String

    private let doneAction: DoneEditTaskAction

    init(title: String,
         doneAction: DoneEditTaskAction,
         @ViewBuilder content: () -> Content)
    {
        self.content = content()
        self.title = title
        self.doneAction = doneAction
    }

    var body: some View {
        NavigationView {
            content
                .navigationBarTitle(Text(title), displayMode: .inline)
                .navigationBarItems(
                    trailing: Button(L10n.EditTask.done, action: doneAction.handler)
                        .disabled(!doneAction.isEnabled)
                )
        }
    }
}

// MARK: - Previews

struct EditTaskNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        EditTaskNavigationView(
            title: L10n.UpdateTask.title,
            doneAction: .init(isEnabled: true, handler: {})
        ) {
            EditTaskView(
                title: .constant("Update Task"),
                description: .constant("")
            )
        }
    }
}
