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

    var taskDetail: TaskDetailComponent {
        TaskDetailComponent(parent: self)
    }

    var newTask: NewTaskComponent {
        NewTaskComponent(parent: self)
    }

    var updateTask: UpdateTaskComponent {
        UpdateTaskComponent(parent: self)
    }
}

// MARK: - Statistics

extension AppComponent {
    var statistics: StatisticsComponent {
        StatisticsComponent(parent: self)
    }
}

// MARK: - Settings

extension AppComponent {
    var settings: SettingsComponent {
        SettingsComponent(parent: self)
    }
}
