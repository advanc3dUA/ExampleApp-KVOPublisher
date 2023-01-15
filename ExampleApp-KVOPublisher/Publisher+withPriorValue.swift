//
//  Publisher+withPriorValue.swift
//  ExampleApp-KVOPublisher
//
//  Created by Yuriy Gudimov on 15.01.2023.
//

import Combine

extension Publisher {
    public func withPriorValue() -> AnyPublisher<(prior: Output?, new: Output), Failure> {
        scan((prior: Output?.none, new: Output?.none)) { (tuple, newValue) in
            (prior: tuple.new, new: newValue)
        }
        .map { (prior: $0.prior, new: $0.new!) }
        .eraseToAnyPublisher()
    }
}
