//
//  NewTaskView.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/29.
//

import SwiftUI

struct NewTaskView: View {
    @StateObject private var component = NewTaskComponent.make()

    var body: some View {
        component.makeContentView()
    }
}

struct NewTaskContentView: View {
    @Environment(\.presentationMode) private var presentationMode

    @ObservedObject var viewModel: NewTaskViewModel

    var body: some View {
        NewTaskNavigationView(
            disabledDone: !viewModel.isInputCompleted,
            onDone: viewModel.makeTask
        ) {
            EditTaskView(
                title: $viewModel.title,
                description: $viewModel.description
            )
            .onReceive(viewModel.$makeTaskResult, perform: self.didReceiveResult)
        }
    }

    private func didReceiveResult(_ result: MakeTaskResult) {
        switch result {
        case .success:
            presentationMode.wrappedValue.dismiss()
        case let .error(message):
            // TODO: Present error HUD
            print(message)
        default:
            break
        }
    }
}

private struct NewTaskNavigationView<Content>: View where Content: View {
    private let content: Content

    private let disabledDone: Bool

    private let onDone: () -> Void

    init(disabledDone: Bool,
         onDone: @escaping () -> Void = {},
         @ViewBuilder content: () -> Content)
    {
        self.content = content()
        self.disabledDone = disabledDone
        self.onDone = onDone
    }

    var body: some View {
        NavigationView {
            content
                .navigationBarTitle(Text(L10n.NewTask.title), displayMode: .inline)
                .navigationBarItems(trailing: Button(L10n.EditTask.done) {
                    onDone()
                }.disabled(disabledDone))
        }
    }
}

// swiftlint:disable type_name
struct NewTaskNavigationView_Preview: PreviewProvider {
    static var previews: some View {
        NewTaskNavigationView(disabledDone: false) {} content: {
            Text("Dummy")
        }
    }
}
