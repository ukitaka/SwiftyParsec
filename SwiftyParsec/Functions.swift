//
//  Functions.swift
//  SwiftyParsec
//
//  Created by Yuki Takahashi on 2017/02/12.
//  Copyright © 2017年 waft. All rights reserved.
//

public func id<A>(_ a: A) -> A {
    return a
}

public func const<A, B>(_ a: A) -> (B) -> A {
    return { _ in return a }
}

public func cons<A>(head: A, tail: [A]) -> [A] {
    return [head] + tail
}
