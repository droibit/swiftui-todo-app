//
//  RxSwift+CombineIntegration.swift
//  Core
//
//  Created by Shinya Kumagai on 2020/11/29.
//

import Combine
import RxRelay
import RxSwift

public class UniversalDisposeBag {
    public let dispose: DisposeBag
    public var cancellables: Set<AnyCancellable>

    public init() {
        dispose = DisposeBag()
        cancellables = []
    }
}

public extension BehaviorRelay {
    func bind(to publisher: Published<Element>.Publisher,
              storeIn cancellableBag: inout Set<AnyCancellable>) -> BehaviorRelay<Element>
    {
        publisher.sink { self.accept($0) }
            .store(in: &cancellableBag)
        return self
    }
}
