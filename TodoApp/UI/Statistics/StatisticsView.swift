//
//  StatisticsView.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/15.
//

import SwiftUI

struct StatisticsView: View {
    @ObservedObject var viewModel: StatisticsViewModel

    var body: some View {
        Navigation {
            Group {
                switch viewModel.getStatisticsResult {
                case .inProgress:
                    InProgressView()
                case let .success(uiState):
                    StatisticsUiStateView(uiState: uiState)
                case let .error(message):
                    TaskErrorView(message: message)
                }
            }
            .onAppear(perform: viewModel.onAppear)
        }
    }
}

// MARK: - Builder

extension StatisticsView {
    struct Builder: View {
        @StateObject private var component = StatisticsComponent.make()

        var body: some View {
            component.makeView()
        }
    }
}

// MARK: - Navigation

private extension StatisticsView {
    struct Navigation<Content>: View where Content: View {
        private let content: Content

        @State private var presentsSettings: Bool = false

        init(@ViewBuilder content: () -> Content) {
            self.content = content()
        }

        var body: some View {
            NavigationView {
                content
                    .navigationBarTitle(Text(L10n.Statistics.title), displayMode: .inline)
                    .navigationBarItems(trailing: Button(action: {
                        presentsSettings = true
                    }, label: {
                        Image(systemName: "gear")
                    }))
                    .sheet(isPresented: $presentsSettings) {}
            }
        }
    }
}

// MARK: - Preview

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView.Navigation {
            Text("Dummy")
        }
    }
}
