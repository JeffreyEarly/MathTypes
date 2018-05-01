//
//  MathProtocols.swift
//  MathTypes
//
//  Created by Jeffrey Early on 4/30/18.
//

// These coupled protocols describe the algebriac structure of the real, imaginary, and complex numbers.

// https://appventure.me/2015/10/17/advanced-practical-enum-examples/

// Notation: think of O as the Operand type and R as the Result type.
protocol RealNumber {
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:RealNumber
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:ComplexNumber
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
    
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:RealNumber
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:ComplexNumber
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
    
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:RealNumber
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:ImaginaryNumber
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
    
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:RealNumber
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:ImaginaryNumber
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
}

protocol ImaginaryNumber {
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:ComplexNumber
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:ImaginaryNumber
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
    
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:ComplexNumber
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:ImaginaryNumber
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
    
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:ImaginaryNumber
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:RealNumber
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
    
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:ImaginaryNumber
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:RealNumber
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
}

protocol ComplexNumber {
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:ComplexNumber
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:ComplexNumber
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
    
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:ComplexNumber
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:ComplexNumber
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
    
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:ComplexNumber
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:ComplexNumber
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
    
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:ComplexNumber
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:ComplexNumber
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
}

protocol PositiveRealNumber {
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:PositiveRealNumber, R:PositiveRealNumber
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:RealNumber
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:ComplexNumber
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
    
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:PositiveRealNumber, R:RealNumber
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:RealNumber
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:ComplexNumber
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
    
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:PositiveRealNumber, R:PositiveRealNumber
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:RealNumber
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:ImaginaryNumber
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
    
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:PositiveRealNumber, R:PositiveRealNumber
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:RealNumber
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:ImaginaryNumber
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
}
