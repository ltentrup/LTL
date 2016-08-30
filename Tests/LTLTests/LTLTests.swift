import XCTest
@testable import LTL

class LTLTests: XCTestCase {
    func testSimple() {
        let ltlString = "GFa"
        let parsed = try! LTL.parse(fromString: ltlString)
        let expected = LTL.UnaryOperator(.Globally, LTL.UnaryOperator(.Eventually, .Proposition("a")))
        XCTAssert(parsed == expected)
    }
    
    func testSimpleParenthesis() {
        let parsed = try! LTL.parse(fromString: "(a)")
        let expected = LTL.Proposition("a")
        XCTAssert(parsed == expected)
    }
    
    func testBinaryOperator() {
        let parsed = try! LTL.parse(fromString: "(a && b)")
        let expected = LTL.BinaryOperator(.And, .Proposition("a"), .Proposition("b"))
        XCTAssert(parsed == expected)
        
        let alternative1 = try! LTL.parse(fromString: "(a & b)")
        XCTAssert(parsed == alternative1)
        let alternative2 = try! LTL.parse(fromString: "(a /\\ b)")
        XCTAssert(parsed == alternative2)
        
        XCTAssertThrowsError(try LTL.parse(fromString: "(a &&& b)"))
    }
    
    func testMissingParenthesis() {
        XCTAssertThrowsError(try LTL.parse(fromString: "(a"))
    }


    static var allTests : [(String, (LTLTests) -> () throws -> Void)] {
        return [
            ("testSimple", testSimple),
            ("testSimpleParenthesis", testSimpleParenthesis),
            ("testBinaryOperator", testBinaryOperator),
            ("testMissingParenthesis", testMissingParenthesis),
        ]
    }
}
