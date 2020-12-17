//
//  SettingsComponent.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/12/17.
//

import Combine
import Core
import NeedleFoundation

protocol SettingsDependency: Dependency {
    var applicationInfo: ApplicationInfo { get }
}

class SettingsComponent: Component<SettingsDependency>, ObservableObject {
    func makeView() -> SettingsView {
        SettingsView(applicationInfo: dependency.applicationInfo)
    }
}

extension SettingsComponent {
    static func make() -> SettingsComponent {
        AppComponent.instance.settings
    }
}
