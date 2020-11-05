//
//  SchedulerProvider.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/05.
//

import RxSwift

class SchedulerProvider {
    let main: SchedulerType
    let background: SchedulerType
    let current: ImmediateSchedulerType
    
    init(main: SchedulerType,
         background: SchedulerType,
         current: ImmediateSchedulerType) {
        self.main = main
        self.background = background
        self.current = current
    }
}

