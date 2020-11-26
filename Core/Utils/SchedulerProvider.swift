//
//  SchedulerProvider.swift
//  Core
//
//  Created by Shinya Kumagai on 2020/11/05.
//

import RxSwift

public class SchedulerProvider {
    public let main: SchedulerType
    public let background: SchedulerType
    public let current: ImmediateSchedulerType

    public init(main: SchedulerType,
                background: SchedulerType,
                current: ImmediateSchedulerType)
    {
        self.main = main
        self.background = background
        self.current = current
    }
}
