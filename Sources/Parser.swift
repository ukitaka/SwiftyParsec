//
//  Parser.swift
//  SwiftyParsec
//
//  Created by Yuki Takahashi on 2017/02/12.
//  Copyright © 2017年 waft. All rights reserved.
//

import Runes

public struct Parser<A> {
    let _parse: (String.UnicodeScalarView) -> ParseResult<A>

    public init(_ parse: @escaping (String.UnicodeScalarView) -> ParseResult<A>) {
        self._parse = parse
    }

    public func parse(UnicodeScalarView: String.UnicodeScalarView) -> ParseResult<A> {
        return _parse(UnicodeScalarView)
    }

    public func parse(string: String) -> ParseResult<A> {
        return _parse(string.unicodeScalars)
    }


    public func map<B>(_ f: @escaping (A) -> B) -> Parser<B> {
        return Parser<B> { self._parse($0).map(f) }
    }
    
    public func map2<B, C>(_ p: @autoclosure @escaping () -> Parser<B>, _ f: @escaping (A, B) -> C) -> Parser<C> {
        return Parser<C> { cv1 in
            switch self._parse(cv1) {
            case .success(let a, let cv2):
                switch p()._parse(cv2) {
                case .success(let b, let cv3):
                    return .success(f(a, b), cv3)
                case .failure(let e):
                    return .failure(e)
                }
            case .failure(let e):
                return .failure(e)
            }
        }
    }
}
