//
//  MathProtocols.swift
//  MathTypes
//
//  Created by Jeffrey Early on 4/30/18.
//

// These coupled protocols describe the algebriac structure of the real, imaginary, and complex numbers.

// https://appventure.me/2015/10/17/advanced-practical-enum-examples/

// We can define the structure with enums, and then make the enum a required property of the number type? Then it doesn't store the enum, but will return the result.
//enum ComplexType {
//    enum RealType {
//
//    }
//}

// Notation: think of O as the Operand type and R as the Result type.
protocol Number  {
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:Number, R:Number
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:Number, R:Number
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:Number, R:Number
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:Number, R:Number
    static func pow<O,R>(lhs: Self, rhs: O) -> R where O:Number, R:Number
    static func log<R>(lhs: Self) -> R where R:Number
}

protocol PositiveRealNumber : RealNumber {
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:PositiveRealNumber, R:PositiveRealNumber
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:NegativeRealNumber, R:RealNumber
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:RealNumber
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:ComplexNumber
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
    
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:PositiveRealNumber, R:RealNumber
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:NegativeRealNumber, R:PositiveRealNumber
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:RealNumber
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:ComplexNumber
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
    
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:PositiveRealNumber, R:PositiveRealNumber
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:NegativeRealNumber, R:NegativeRealNumber
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:RealNumber
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:ImaginaryNumber
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
    
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:PositiveRealNumber, R:PositiveRealNumber
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:NegativeRealNumber, R:NegativeRealNumber
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:RealNumber
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:ImaginaryNumber
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
}


protocol NegativeRealNumber : RealNumber {
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:PositiveRealNumber, R:RealNumber
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:NegativeRealNumber, R:NegativeRealNumber
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:RealNumber
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:ComplexNumber
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
    
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:PositiveRealNumber, R:NegativeRealNumber
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:NegativeRealNumber, R:RealNumber
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:RealNumber
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:ComplexNumber
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
    
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:PositiveRealNumber, R:NegativeRealNumber
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:NegativeRealNumber, R:PositiveRealNumber
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:RealNumber
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:ImaginaryNumber
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
    
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:PositiveRealNumber, R:NegativeRealNumber
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:NegativeRealNumber, R:PositiveRealNumber
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:RealNumber
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:ImaginaryNumber
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
}

protocol RealNumber : ComplexNumber, Strideable {
    associatedtype StorageType
    
    init(_ real: StorageType)
    
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:PositiveRealNumber, R:RealNumber
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:NegativeRealNumber, R:RealNumber
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:RealNumber
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:ComplexNumber
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
    
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:PositiveRealNumber, R:RealNumber
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:NegativeRealNumber, R:RealNumber
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:RealNumber
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:ComplexNumber
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
    
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:PositiveRealNumber, R:RealNumber
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:NegativeRealNumber, R:RealNumber
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:RealNumber
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:ImaginaryNumber
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
    
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:PositiveRealNumber, R:RealNumber
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:NegativeRealNumber, R:RealNumber
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:RealNumber
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:ImaginaryNumber
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
}

protocol ImaginaryNumber : ComplexNumber, Strideable {
    associatedtype StorageType
    
    init(_ imag: StorageType)
    
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:PositiveRealNumber, R:ComplexNumber
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:NegativeRealNumber, R:ComplexNumber
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:ComplexNumber
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:ImaginaryNumber
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
    
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:PositiveRealNumber, R:ComplexNumber
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:NegativeRealNumber, R:ComplexNumber
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:ComplexNumber
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:ImaginaryNumber
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
    
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:PositiveRealNumber, R:ImaginaryNumber
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:NegativeRealNumber, R:ImaginaryNumber
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:ImaginaryNumber
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:RealNumber
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
    
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:PositiveRealNumber, R:ImaginaryNumber
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:NegativeRealNumber, R:ImaginaryNumber
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:ImaginaryNumber
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:RealNumber
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
}

protocol ComplexNumber : ExpressibleByIntegerLiteral, CustomStringConvertible, Equatable {
    associatedtype RealType : RealNumber
    associatedtype ImaginaryType : ImaginaryNumber
    
    static var real: RealType {get}
    static var imag: ImaginaryType {get}
    
    init(real: RealType, imag: ImaginaryType)
    
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:PositiveRealNumber, R:ComplexNumber
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:NegativeRealNumber, R:ComplexNumber
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:ComplexNumber
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:ComplexNumber
    static func +<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
    
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:PositiveRealNumber, R:ComplexNumber
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:NegativeRealNumber, R:ComplexNumber
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:ComplexNumber
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:ComplexNumber
    static func -<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
    
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:PositiveRealNumber, R:ComplexNumber
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:NegativeRealNumber, R:ComplexNumber
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:ComplexNumber
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:ComplexNumber
    static func *<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
    
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:PositiveRealNumber, R:ComplexNumber
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:NegativeRealNumber, R:ComplexNumber
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:RealNumber, R:ComplexNumber
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:ImaginaryNumber, R:ComplexNumber
    static func /<O,R>(lhs: Self, rhs: O) -> R where O:ComplexNumber, R:ComplexNumber
}

