//
//  OpenSettingsURL.swift
//  Core
//
//  Created by Shinya Kumagai on 2020/12/17.
//

import SwiftUI
import UIKit

struct OpenSettingsURLKey: EnvironmentKey {
    static let defaultValue = URL(string: UIApplication.openSettingsURLString)!
}

public extension EnvironmentValues {
    var openSettingsURL: URL {
        self[OpenSettingsURLKey.self]
    }
}
