//
//  AppComponent+View.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/19.
//

import Foundation

// MAKR: - TO-DO

extension AppComponent {
    var tasks: TasksComponent {
        TasksComponent(parent: self)
    }

    var detailTask: DetailTaskComponent {
        DetailTaskComponent(parent: self)
    }

    var newTask: NewTaskComponent {
        NewTaskComponent(parent: self)
    }
}
