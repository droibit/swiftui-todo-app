// swiftlint:disable weak_delegate

import SwiftUI

@main
struct TodoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            TabView {
                TasksView.Builder()
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text(L10n.Tasks.title)
                    }
                    .tag(0)
                StatisticsView.Builder()
                    .tabItem {
                        Image(systemName: "ellipsis.circle")
                        Text(L10n.Statistics.title)
                    }
                    .tag(1)
            }.accentColor(Color(Asset.Colors.accentColor.color))
        }
    }
}
