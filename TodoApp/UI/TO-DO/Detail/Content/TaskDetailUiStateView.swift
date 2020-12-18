//
//  TaskDetailUiStateView.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/12/10.
//

import Core
import SwiftUI

struct TaskDetailUiStateView: View {
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }()

    private let uiState: TaskDetailUiState
    private let onToggleCompleted: () -> Void
    private let onDelete: () -> Void

    init(uiState: TaskDetailUiState,
         onToggleCompleted: @escaping () -> Void = {},
         onDelete: @escaping () -> Void = {})
    {
        self.uiState = uiState
        self.onToggleCompleted = onToggleCompleted
        self.onDelete = onDelete
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Button(action: onToggleCompleted, label: {
                        Checkmark(checked: uiState.task.isCompleted)
                            .foregroundColor(.primary)
                    })

                    Text(uiState.task.title)
                        .font(.title3)
                        .bold()
                    Spacer()
                }

                if !uiState.task.description.isEmpty {
                    Text(uiState.task.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                HStack {
                    Label(L10n.DetailTask.createdAtLabel(
                        Self.dateFormatter.string(from: uiState.task.createdAt)
                    ), systemImage: "calendar.circle")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    Spacer()
                }

                HStack {
                    Button(action: onDelete, label: {
                        Image(systemName: "trash")
                            .font(.body)
                            .padding()
                    })
                }.frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
    }
}

// MARK: - Previews

struct TaskDetailUiStateView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TaskDetailUiStateView(
                uiState: .init(task: Task(
                    id: "task",
                    title: "Example Domain",
                    description: "This domain is for use in illustrative examples in documents. You may use this domain in literature without prior coordination or asking for permission.",
                    isCompleted: true,
                    createdAt: Date(timeIntervalSince1970: 1_607_094_000)
                ))
            )

            TaskDetailUiStateView(
                uiState: .init(task: Task(
                    id: "task",
                    title: "By something",
                    description: "...",
                    isCompleted: true,
                    createdAt: Date(timeIntervalSince1970: 1_607_094_000)
                ))
            )
        }
    }
}
