//
//  URLParser.swift
//  Examples
//
//  Created by Yuki Takahashi on 2017/02/17.
//  Copyright © 2017年 waft. All rights reserved.
//

import SwiftyParsec

/// URL Parser
/// see: https://tools.ietf.org/html/rfc1738#section-4
final public class URLParser {
    public enum URL {
        case http
        case ftp
        case news
        case nntp
        case telnet
        case gopher
        case wais
        case mailto
        case file
        case prospero
        case other
    }
    
    public func parseURL() -> Parser<URL> {
        fatalError("not implemented")
    }

    // MARK: - Scheme

    public typealias Scheme = String

    // scheme = 1*[ lowalpha | digit | "+" | "-" | "." ]

    public func parseScheme() -> Parser<Scheme> {
        fatalError("not implemented")
    }
}
