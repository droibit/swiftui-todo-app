//
//  TaskItemView.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/19.
//

import SwiftUI

struct TaskItemView: View {
    let task: Task

    var body: some View {
        HStack {
            task.isCompleted.checkmarkIcon
                .font(Font.headline.bold())
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
                task: .init(
                    id: "",
                    title: "Test TO-DO",
                    description: "description",
                    isCompleted: false,
                    createdAt: Date()
                )
            )
            .previewLayout(.sizeThatFits)

            TaskItemView(
                task: .init(
                    id: "",
                    title: "Test TO-DO",
                    description: "",
                    isCompleted: true,
                    createdAt: Date()
                )
            )
            .previewLayout(.sizeThatFits)
        }
    }
}

private extension Bool {
    var checkmarkIcon: Image {
        if self {
            return Image(systemName: "checkmark.square")
        } else {
            return Image(systemName: "square")
        }
    }
}
