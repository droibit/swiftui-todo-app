//
//  AppComponent+View.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/19.
//

import Foundation

extension AppComponent {
    var tasks: TasksComponent {
        TasksComponent(parent: self)
    }
}
