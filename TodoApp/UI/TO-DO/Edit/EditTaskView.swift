//
//  EditTaskView.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/29.
//

import SwiftUI

struct EditTaskView: View {
    @Binding var title: String
    @Binding var description: String

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                titleView(maxHeight: geometry.size.height / 4)
                descriptionView()
            }
            .onTapGesture {
                hideKeyboard()
            }
            .frame(maxWidth: .infinity)
        }
    }

    private func titleView(maxHeight: CGFloat) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(L10n.EditTask.titleLabel)
                .font(.subheadline)
                .foregroundColor(.secondary)
            VStack {
                TextEditor(text: $title)
                    .font(.title3)
                    .multilineTextAlignment(.leading)
                Divider()
            }
        }
        .frame(maxHeight: maxHeight)
        .padding()
    }

    private func descriptionView() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(L10n.EditTask.Description.label)
                .font(.subheadline)
                .foregroundColor(.secondary)
            VStack {
                // TODO: Add placeholder
                TextEditor(text: $description)
                    .font(.title3)
                    .multilineTextAlignment(.leading)
                Divider()
            }.frame(maxHeight: .infinity)
        }
        .padding()
    }
}

// MARK: - Previews

struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        EditTaskView(
            title: .constant("Buy something"),
            description: .constant("...")
        )
    }
}
