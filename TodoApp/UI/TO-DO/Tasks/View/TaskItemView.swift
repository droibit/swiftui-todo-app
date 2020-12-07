//
//  TaskItemView.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/19.
//

import Core
import SwiftUI

struct TaskItemView: View {
    let task: Task

    // TODO: review text color.
    var body: some View {
        HStack {
            Checkmark(checked: task.isCompleted)
                .padding(.all, 4)

            VStack(alignment: .leading, spacing: 4) {
                Text(task.title)
                    .font(.headline)

                if !task.description.isEmpty {
                    Text(task.description)
                        .lineLimit(1)
                        .font(.subheadline)
                }
            }
        }
    }
}

struct TaskItemView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TaskItemView(
                task: Task(
                    id: "",
                    title: "Test TO-DO",
                    description: "description",
                    isCompleted: false,
                    createdAt: Date()
                )
            )
            .previewLayout(.sizeThatFits)
            .environment(\.colorScheme, .light)

            TaskItemView(
                task: Task(
                    id: "",
                    title: "Test TO-DO",
                    description: "",
                    isCompleted: true,
                    createdAt: Date()
                )
            )
            .previewLayout(.sizeThatFits)
            .environment(\.colorScheme, .dark)
        }
    }
}
