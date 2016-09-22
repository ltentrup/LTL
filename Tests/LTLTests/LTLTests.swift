import XCTest
@testable import LTL

class LTLTests: XCTestCase {
    func testSimple() {
        let ltlString = "GFa"
        let parsed = try! LTL.parse(fromString: ltlString)
        let expected = LTL.UnaryOperator(.Globally, LTL.UnaryOperator(.Eventually, .Proposition("a")))
        XCTAssertEqual(parsed, expected)
    }
    
    func testSimpleParenthesis() {
        let parsed = try! LTL.parse(fromString: "(a)")
        let expected = LTL.Proposition("a")
        XCTAssertEqual(parsed, expected)
    }
    
    func testBinaryOperator() {
        let parsed = try! LTL.parse(fromString: "(a && b)")
        let expected = LTL.BinaryOperator(.And, .Proposition("a"), .Proposition("b"))
        XCTAssertEqual(parsed, expected)
        
        let alternative1 = try! LTL.parse(fromString: "(a & b)")
        XCTAssertEqual(parsed, alternative1)
        let alternative2 = try! LTL.parse(fromString: "(a /\\ b)")
        XCTAssertEqual(parsed, alternative2)
        
        XCTAssertThrowsError(try LTL.parse(fromString: "(a &&& b)"))
    }
    
    func testMissingParenthesis() {
        XCTAssertThrowsError(try LTL.parse(fromString: "(a"))
    }
    
    func testPropositionsWithUnderscore() {
        let parsed = try! LTL.parse(fromString: "(a_1)")
        let expected = LTL.Proposition("a_1")
        XCTAssertEqual(parsed, expected)
    }
    
    func testNNF() {
        let parsed = try! LTL.parse(fromString: "!(a & b)")
        let expected = try! LTL.parse(fromString: "!a | !b")
        XCTAssertEqual(parsed.nnf, expected)
    }


    static var allTests : [(String, (LTLTests) -> () throws -> Void)] {
        return [
            ("testSimple", testSimple),
            ("testSimpleParenthesis", testSimpleParenthesis),
            ("testBinaryOperator", testBinaryOperator),
            ("testMissingParenthesis", testMissingParenthesis),
            ("testPropositionsWithUnderscore", testPropositionsWithUnderscore)
        ]
    }
}
