//
//  Parser+Generate.swift
//  SwiftyParsec
//
//  Created by Yuki Takahashi on 2017/02/17.
//  Copyright © 2017年 waft. All rights reserved.
//

public extension Parser {
    public static func success(_ a: A) -> Parser<A> {
        return Parser<A> { cv in
            return .success(a, cv)
        }
    }

    public static func unicodeScalar(_ u: UnicodeScalar) -> Parser<UnicodeScalar> {
        return Parser<UnicodeScalar> { uv in
            guard uv.first == u  else {
                return .failure(.error)
            }
            return .success(u, uv.dropFirst())
        }
    }

    public static func characterSet(_ cs: CharacterSet) -> Parser<UnicodeScalar> {
        return Parser<UnicodeScalar> { uv in
            guard let first = uv.first, cs.contains(first)  else {
                return .failure(.error)
            }
            return .success(first, uv.dropFirst())
        }
    }

    public static func string(_ s: String) -> Parser<String> {
        return Parser<String> { cv in
            guard cv.starts(with: s.unicodeScalars) else {
                return .failure(.error)
            }
            return .success(s, cv.dropFirst(s.unicodeScalars.count))
        }
    }
}

// MARK: -

public extension Parser {
    public static func alphabets() -> Parser<UnicodeScalar> {
        return characterSet(.alphanumerics)

    }
}
