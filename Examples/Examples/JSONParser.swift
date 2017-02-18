//
//  JSONParser.swift
//  Examples
//
//  Created by Yuki Takahashi on 2017/02/18.
//  Copyright © 2017年 waft. All rights reserved.
//

import SwiftyParsec
//import Runes

public indirect enum JSON {
    case null
    case number(Double)
    case string(String)
    case bool(Bool)
    case array([JSON])
    case object([String: JSON])
}

final public class JSONParser {
    func parseNull() -> Parser<JSON> {
        fatalError()
//        return .string("null") *> .success(.null)
    }
}
