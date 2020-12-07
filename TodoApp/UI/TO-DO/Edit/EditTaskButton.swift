//
//  EditTaskButton.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/12/05.
//

import SwiftUI

struct EditTaskButton: View {
    @Environment(\.editMode) private var editMode

    private let onEdit: () -> Void
    private let onDone: () -> Void

    init(onEdit: @escaping () -> Void,
         onDone: @escaping () -> Void)
    {
        self.onEdit = onEdit
        self.onDone = onDone
    }

    private var isEditing: Bool {
        editMode?.wrappedValue.isEditing == true
    }

    var body: some View {
        Button(
            isEditing ? L10n.EditTask.edit : L10n.EditTask.done
        ) {
            isEditing ? onEdit() : onDone()
        }
    }
}
