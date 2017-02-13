//
//  Parser+Operators.swift
//  SwiftyParsec
//
//  Created by Yuki Takahashi on 2017/02/12.
//  Copyright © 2017年 waft. All rights reserved.
//

import Runes

public func <|> <A>(lhs: Parser<A>, rhs: @escaping @autoclosure () -> Parser<A>) -> Parser<A> {
    return lhs.or(rhs)
}

public func <^> <A, B>(lhs: @escaping (A) -> B, _ rhs: Parser<A>) -> Parser<B> {
    return rhs.map(lhs)
}

public func <*> <A, B>(lhs: Parser<(A) -> B>, _ rhs: @escaping @autoclosure () -> Parser<A>) -> Parser<B> {
    return lhs.map2(rhs()) { return $0($1) }
}

public func *> <A, B>(lhs: Parser<A>, rhs: @autoclosure @escaping () -> Parser<B>) -> Parser<B> {
    return Parser<B> { cv in
        switch lhs.parse(characterView: cv) {
        case .success(_, let cv2):
            return rhs().parse(characterView: cv2)
        case .failure(let e):
            return .failure(e)
        }
    }
}

public func <* <A, B>(lhs: Parser<A>, rhs: @autoclosure @escaping () -> Parser<B>) -> Parser<A> {
    return Parser<A> { cv in
        switch lhs.parse(characterView: cv) {
        case .success(let a, let cv2):
            switch rhs().parse(characterView: cv2) {
            case .success(_, let cv3):
                return .success(a, cv3)
            case .failure(let e):
                return .failure(e)
            }
        case .failure(let e):
            return .failure(e)
        }
    }
}
