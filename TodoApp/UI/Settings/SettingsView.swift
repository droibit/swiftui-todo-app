//
//  SettingsView.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/12/17.
//

import Core
import SwiftUI

struct SettingsView: View {
    @Environment(\.openSettingsURL) private var openSettingsURL

    private let appInfo: ApplicationInfo

    init(applicationInfo: ApplicationInfo) {
        appInfo = applicationInfo
    }

    var body: some View {
        Navigation {
            Form {
                Section(header: Text(L10n.Settings.App.title)) {
                    HStack {
                        Text(L10n.Settings.App.buildVersion)
                            .onTapGesture {}
                        Spacer()
                        Text("\(appInfo.version) (\(appInfo.build))")
                    }
                }

                Section {
                    Link(L10n.Settings.App.sourceCode, destination: appInfo.sourceCodeURL)
                        .foregroundColor(.primary)
                    Link(L10n.Settings.App.openSourceLicenses, destination: openSettingsURL)
                        .foregroundColor(.primary)
                }
            }
            .listStyle(GroupedListStyle())
        }
    }
}

// MARK: - Builder

extension SettingsView {
    struct Builder: View {
        @StateObject private var component = SettingsComponent.make()

        var body: some View {
            component.makeView()
        }
    }
}

// MARK: - Navigation

extension SettingsView {
    struct Navigation<Content>: View where Content: View {
        private let content: Content

        init(@ViewBuilder content: () -> Content) {
            self.content = content()
        }

        var body: some View {
            NavigationView {
                content
                    .navigationBarTitle(Text(L10n.Settings.title), displayMode: .inline)
            }
        }
    }
}

// MARK: - Preview

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(
            applicationInfo: .init(
                version: "1.0.0",
                build: "1",
                sourceCodeURL: URL(string: "https://example.com")!
            )
        )
    }
}
