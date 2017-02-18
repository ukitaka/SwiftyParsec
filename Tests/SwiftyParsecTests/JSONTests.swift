import XCTest
@testable import SwiftyParsec
import Runes

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
        return .string("null") *> .success(.null)
    }
}

class SwiftyParsecTests: XCTestCase {
    func testExample() { }
}
