public enum LTL: CustomStringConvertible, Equatable {
    case Proposition(String)
    indirect case UnaryOperator(LTLToken, LTL)
    indirect case BinaryOperator(LTLToken, LTL, LTL)
    
    // CustomStringConvertible
    public var description: String {
        switch self {
        case .Proposition(let name):
            return name
        case .UnaryOperator(let op, let operand):
            return "\(op) \(operand)"
        case .BinaryOperator(let op, let lhs, let rhs):
            return "(\(lhs) \(op) \(rhs))"
        }
    }
    
    // Equatable
    public static func == (lhs: LTL, rhs: LTL) -> Bool {
        switch (lhs, rhs) {
        case (.Proposition(let lhsName), .Proposition(let rhsName)):
            return lhsName == rhsName
        case (.UnaryOperator(let lhsOp, let lhsOperand), .UnaryOperator(let rhsOp, let rhsOperand)):
            return lhsOp == rhsOp && lhsOperand == rhsOperand
        case (.BinaryOperator(let lhsOp, let lhsLhs, let lhsRhs), .BinaryOperator(let rhsOp, let rhsLhs, let rhsRhs)):
            return lhsOp == rhsOp && lhsLhs == rhsLhs && lhsRhs == rhsRhs
        default:
            return false
        }
    }
    
    public static func parse(fromString string: String) throws -> LTL {
        let scanner = ScalarScanner(scalars: string.unicodeScalars)
        let lexer = LTLLexer(scanner: scanner)
        var parser = LTLParser(lexer: lexer)
        return try parser.parse()
    }
}