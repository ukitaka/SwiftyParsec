//
//  Parser+Combinator.swift
//  SwiftyParsec
//
//  Created by Yuki Takahashi on 2017/02/17.
//  Copyright © 2017年 waft. All rights reserved.
//

import Runes

// MARK: -

public extension Parser {
    public func or(_ p: @autoclosure @escaping () -> Parser<A>) -> Parser<A> {
        return Parser<A> { cv in
            self._parse(cv).orElse(p()._parse(cv))
        }
    }

    public func product<B>(_ p: @autoclosure @escaping () -> Parser<B>) -> Parser<(A, B)> {
        return map2(p) { ($0, $1) }
    }
}

// MARK: -

public extension Parser {
    public func zeroOrOne() -> Parser<A?> {
        return Parser<A?> { cv in
            return self._parse(cv)
                .map(Optional.some)
                .orElse(.success(nil, cv))
        }
    }

    public func many() -> Parser<[A]> {
        return many1() <|> .success([])
    }

    public func many1() -> Parser<[A]> {
        return map2(self.many(), cons)
    }
}

// MARK: -

public extension Parser {
    public func skipMany() -> Parser<Void> {
        return skipMany1() <|> .success(())
    }

    public func skipMany1() -> Parser<Void> {
        return self *> self.skipMany()
    }
}
