//
//  View+Keyboard.swift
//  Core
//
//  Created by Shinya Kumagai on 2020/11/29.
//

import SwiftUI

#if canImport(UIKit)
    public extension View {
        func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
#endif
