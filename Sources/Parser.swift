//
//  Parser.swift
//  SwiftyParsec
//
//  Created by Yuki Takahashi on 2017/02/12.
//  Copyright © 2017年 waft. All rights reserved.
//

import Runes

public struct Parser<A> {
    let _parse: (String.CharacterView) -> ParseResult<A>

    public func parse(characterView: String.CharacterView) -> ParseResult<A> {
        return _parse(characterView)
    }

    public func parse(string: String) -> ParseResult<A> {
        return _parse(string.characters)
    }

    public init(_ parse: @escaping (String.CharacterView) -> ParseResult<A>) {
        self._parse = parse
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

// MARK: -

public extension Parser {
    public static func success(_ a: A) -> Parser<A> {
        return Parser<A> { cv in
            return .success(a, cv)
        }
    }

    public static func character(_ c: Character) -> Parser<Character> {
        return Parser<Character> { cv in
            guard cv.first == c  else {
                return .failure(.error)
            }
            return .success(c, cv.dropFirst())
        }
    }
    
    public static func string(_ s: String) -> Parser<String> {
        return Parser<String> { cv in
            guard cv.starts(with: s.characters) else {
                return .failure(.error)
            }
            return .success(s, cv.dropFirst(s.characters.count))
        }
    }
}

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
