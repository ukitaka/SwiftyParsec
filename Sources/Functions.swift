//
//  Functions.swift
//  SwiftyParsec
//
//  Created by Yuki Takahashi on 2017/02/12.
//  Copyright © 2017年 waft. All rights reserved.
//

func id<A>(_ a: A) -> A {
    return a
}

func const<A, B>(_ a: A) -> (B) -> A {
    return { _ in return a }
}

func cons<A>(head: A, tail: [A]) -> [A] {
    return [head] + tail
}
