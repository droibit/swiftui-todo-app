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
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }()

    @Environment(\.presentationMode) private var presentationMode

    @ObservedObject var viewModel: DetailTaskViewModel

    var body: some View {
        DetailTaskNavigation(onEdit: onEdit) {
            _DetailTaskContentView(
                task: viewModel.task,
                onToggleCompleted: viewModel.toggleTaskCompleted,
                onDelete: viewModel.deleteTask
            )
            .onReceive(viewModel.$deleteTaskResult, perform: self.onReceiveResult)
            .onReceive(viewModel.$toggleTaskCompletedResult, perform: self.onReceiveResult)
            .onAppear(perform: viewModel.onAppear)
        }
    }

    private func onEdit() {}

    private func onReceiveResult(result: ToggleTaskCompletedResult) {
        guard case .error = result else {
            return
        }
        presentationMode.wrappedValue.dismiss()
    }

    private func onReceiveResult(_ result: DeleteTaskResult) {
        switch result {
        case .inProgress:
            // TODO: Show progress.
            break
        case .success, .error:
            presentationMode.wrappedValue.dismiss()
        case .none:
            break
        }
    }
}

private struct _DetailTaskContentView: View {
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }()

    private let task: Task
    private let onToggleCompleted: () -> Void
    private let onDelete: () -> Void

    init(task: Task,
         onToggleCompleted: @escaping () -> Void = {},
         onDelete: @escaping () -> Void = {})
    {
        self.task = task
        self.onToggleCompleted = onToggleCompleted
        self.onDelete = onDelete
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Button(action: onToggleCompleted, label: {
                        Checkmark(checked: task.isCompleted)
                            .foregroundColor(.primary)
                    })

                    Text(task.title)
                        .font(.title3)
                        .bold()
                    Spacer()
                }

                if !task.description.isEmpty {
                    Text(task.description)
                        .font(.subheadline)
                }

                HStack {
                    Label(L10n.DetailTask.createdAtLabel(
                        Self.dateFormatter.string(from: task.createdAt)
                    ), systemImage: "calendar.circle")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    Spacer()
                }

                HStack {
                    Button("Delete", action: onDelete)
                        .font(.body)
                        .padding()
                }.frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
    }
}

// MARK: - DetailTaskNavigation

private struct DetailTaskNavigation<Content>: View where Content: View {
    private let onEdit: () -> Void
    private let content: Content

    init(onEdit: @escaping () -> Void = {},
         @ViewBuilder content: () -> Content)
    {
        self.onEdit = onEdit
        self.content = content()
    }

    var body: some View {
        content
            .navigationBarTitle(Text(L10n.DetailTask.title), displayMode: .inline)
            .navigationBarItems(trailing: Button(L10n.DetailTask.edit, action: onEdit))
    }
}

// MARK: - Preview

struct DetailTaskContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                DetailTaskNavigation {
                    _DetailTaskContentView(
                        task: Task(
                            id: "task",
                            title: "Example Domain",
                            description: "This domain is for use in illustrative examples in documents. You may use this domain in literature without prior coordination or asking for permission.",
                            isCompleted: true,
                            createdAt: Date(timeIntervalSince1970: 1_607_094_000)
                        )
                    )
                }
            }

            NavigationView {
                DetailTaskNavigation {
                    _DetailTaskContentView(
                        task: Task(
                            id: "task",
                            title: "By something",
                            description: "...",
                            isCompleted: true,
                            createdAt: Date(timeIntervalSince1970: 1_607_094_000)
                        )
                    )
                }
            }
        }
    }
}
