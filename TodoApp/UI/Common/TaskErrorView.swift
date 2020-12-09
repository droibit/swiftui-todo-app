//
//  TaskErrorView.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/12/09.
//

import SwiftUI

struct TaskErrorView: View {
    let message: String
    // TODO: Retry to get tasks.
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.circle")
                .font(Font.system(size: 40))

            Text(message)
                .font(Font.subheadline.weight(.regular))
                .padding(.horizontal)
        }
    }
}

struct TaskErrorView_Previews: PreviewProvider {
    static var previews: some View {
        TaskErrorView(message: "Failed to get tasks.")
    }
}
