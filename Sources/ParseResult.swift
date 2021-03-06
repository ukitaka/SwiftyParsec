//
//  ParseResult.swift
//  SwiftyParsec
//
//  Created by Yuki Takahashi on 2017/02/12.
//  Copyright © 2017年 waft. All rights reserved.
//

public enum ParseResult<A> {
    case success(A, String.UnicodeScalarView)
    case failure(ParseError)
}

public extension ParseResult {
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
    
    public func map<B>(_ f: (A) -> B) -> ParseResult<B> {
        switch self {
        case .success(let a, let c):
            return .success(f(a), c)
        case .failure(let e):
            return .failure(e)
        }
    }

    public func orElse(_ result: @escaping @autoclosure () -> ParseResult<A>) -> ParseResult<A> {
        switch self {
        case .success:
            return self
        case .failure:
            return result()
        }
    }
}
