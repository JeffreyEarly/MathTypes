// 1. We define protocols to describe the algebraic types, and the algebraic structure. Requires RawType : Numeric.
// 2. Now create structs that have RawType: ScalarType (:Numeric). These types gain Strideable, Literals, etc.
// 3. Promotion works when a *higher* level type, agrees it can consume a lower level type.
// 4. Can the higher level type have a 'promotion rule' that we can codify somehow?

//===----------------------------------------------------------------------===//
// Basic Math Types
//===----------------------------------------------------------------------===//

public typealias RealInt = Real<Int>
public typealias RealFloat = Real<Float>
public typealias RealDouble = Real<Double>

public typealias ImaginaryInt = Imaginary<Int>
public typealias ImaginaryFloat = Imaginary<Float>
public typealias ImaginaryDouble = Imaginary<Double>

public typealias ComplexInt = Complex<Int>
public typealias ComplexFloat = Complex<Float>
public typealias ComplexDouble = Complex<Double>

//public let im : ImaginaryInt = 1

// Note that the requirement T.Stride == T implies T:SignedNumeric.
public struct Real<T> : RealNumber where T:Strideable, T.Stride == T {
    public var raw : T
    
    public init(_ real: T) {
        self.raw = real
    }
}

public struct Imaginary<T> : ImaginaryNumber where T:Strideable, T.Stride == T {
    public var raw : T
    
    public init(_ imag: T) {
        self.raw = imag
    }
}

public struct Complex<T> : ComplexNumber where T:Strideable, T.Stride == T {
    public var real : Real<T>
    public var imag : Imaginary<T>
    
    public init(real: Real<T>, imag: Imaginary<T>) {
        self.real = real
        self.imag = imag
    }
    
    public init(real: T, imag: T) {
        self.real = Real(real)
        self.imag = Imaginary(imag)
    }
}

//===----------------------------------------------------------------------===//
// Protocols to establish the algebraic structure
//===----------------------------------------------------------------------===//

public protocol RealNumber {
    associatedtype RawType : Strideable where RawType.Stride == RawType
    var raw : RawType {get set}
    init(_ real: RawType)
}

public protocol ImaginaryNumber {
    associatedtype RawType : Strideable where RawType.Stride == RawType
    var raw : RawType {get set}
    init(_ imag: RawType)
}

public protocol ComplexNumber {
    associatedtype RealRawType : RealNumber
    associatedtype ImagRawType : ImaginaryNumber
    var real : RealRawType {get set} //where Self.RawType == RealNumber.RawType
    var imag : ImagRawType {get set} //where Self.RawType == RealNumber.RawType
    init(real: RealRawType, imag: ImagRawType)
}

// To satisfy the RealAlgebra protocol, a structure must be able to add itself to another RealNumber.
// No, see, this requirement doesn't make sense: you can't require adding two different rawTypes.
// But, we can change this to some other protocol, that says you can add things together that are scalar types
//protocol RealScalarAlgebra : RealNumber {
//    associatedtype RealType : RealNumber where Self.RawType : ScalarType, RealType.RawType : UpperScalarType
//    static func + (lhs: Self, rhs: RealType) -> RealType
//    static func + (lhs: RealType, rhs: Self) -> RealType
//}

public protocol RealNumberPromotable : RealNumber {
    associatedtype PromotableRawType
    static func promote (_ real: PromotableRawType) -> Self.RawType
}

extension Real : RealNumberPromotable where T == Int {
    public typealias PromotableRawType = Int
    
    public static func promote(_ real: Int) -> Int {
        return real
    }
}

//extension Real : RealNumberPromotable where T == Double {
////    typealias PromotableRealNumber = Real<Int>
//    static func promote(_ real: Int) -> Double {
//        return T(real)
//    }
//}
//
//extension Real where T == Double {
//    static func promote(_ real: Float) -> Double {
//        return T(real)
//    }
//}

public extension RealNumberPromotable {
    static func +<S>(lhs: S, rhs: Self) -> Self where S:RealNumber, S.RawType == PromotableRawType {
        return Self.init( self.promote(lhs.raw) + rhs.raw )
    }
    // This is reflexive if the types are the same, so the second version gives an 'ambiguous' error.
//    static func +<S>(lhs: Self, rhs: S ) -> Self where S:RealNumber, S.RawType == PromotableRawType {
//        return Self.init( lhs.raw + self.promote(rhs.raw) )
//    }
}

//public func +<S,T>(lhs: S, rhs: T) -> T where T:RealNumberPromotable, S:RealNumber, S.RawType == T.PromotableRawType {
//    return T.init( T.promote(lhs.raw) + rhs.raw )
//}
//public func +<S,T>(lhs: T, rhs: S ) -> T where T:RealNumberPromotable, S:RealNumber, S.RawType == T.PromotableRawType {
//    return T.init( lhs.raw + T.promote(rhs.raw) )
//}

//protocol RealScalarNumber : RealNumber where RawType: ScalarType {
////    static func + (lhs: Self, rhs: RealScalarNumber) -> RealScalarNumber
////    static func + (lhs: RealScalarNumber, rhs: Self) -> RealScalarNumber
//}
//
//protocol RealUpperScalarNumber : RealNumber where RawType: UpperScalarType {
//}

//===----------------------------------------------------------------------===//
// Implementations of the algebra for scalar types
//===----------------------------------------------------------------------===//

//public protocol ScalarType : Strideable, SignedNumeric {
//    init(_ source: Int)
//    init(_ source: Float)
//    init(_ source: Double)
//    var doubleValue : Double {get}
//}
//extension Int : ScalarType {
//    public var doubleValue: Double {
//        return Double(self)
//    }
//};
//extension Float : ScalarType {
//    public var doubleValue: Double {
//        return Double(self)
//    }
//};
//extension Double : ScalarType {
//    public var doubleValue: Double {
//        return self
//    }
//};
//
//public protocol UpperScalarType : ScalarType {
////    init(_ source: Int)
////    init(_ source: Float)
////    init(_ source: Double)
////    var doubleValue : Double {get}
//}
//extension Int : UpperScalarType {};
//extension Float : UpperScalarType {};
//extension Double : UpperScalarType {};
//
//extension Real {
//    // reality is this: either self and realtype are the same, and therefore the return value is the same. Otherwise  we don't know the return type! Which, is a problem for the compiler.
////    static func +<S>(lhs: S, rhs: Real) -> Real where S:RealScalarNumber {
////        let (a,b) = promote(lhs: lhs.raw, rhs: rhs.raw)
////        return Real.init(a + b)
////    }
////
////    static func +<S>(lhs: Real, rhs: S) -> Real where S:RealScalarNumber {
////        let (a,b) = promote(lhs: lhs.raw, rhs: rhs.raw)
////        return Real.init(a + b)
////    }
//
//    // This isn't generic promotion, this promotes to type Self.
////    static func + (lhs: RealType, rhs: Self) -> RealType {
////        let (a,b) = promote(lhs: lhs.raw, rhs: rhs.raw)
////        return RealType.init(a + b)
////    }
//}

//===----------------------------------------------------------------------===//
// MARK: - Real protocol conformance
//===----------------------------------------------------------------------===//

extension Real : ExpressibleByIntegerLiteral {
    public init(integerLiteral value: T.IntegerLiteralType) {
        self.raw = T.init(integerLiteral: value)
    }
}

extension Real : CustomStringConvertible {
    public var description: String {
        return "\(self.raw)"
    }
}

extension Real : Equatable {
    public static func == (lhs: Real, rhs: Real) -> Bool {
        return lhs.raw == rhs.raw
    }
}

//===----------------------------------------------------------------------===//
// MARK: - Type promotion
//===----------------------------------------------------------------------===//

// Default horribleness, that will hopefully never be called.
//func promote<S,T>(lhs: S, rhs: T ) -> (T, T) where S:ScalarType, T:UpperScalarType {
//    return (T.init(lhs.doubleValue),T.init(rhs.doubleValue))
//}
//func promote<S,T>(lhs: T, rhs: S ) -> (T, T) where S:ScalarType, T:UpperScalarType {
//    return (T.init(lhs.doubleValue),T.init(rhs.doubleValue))
//}
//
//
//func promote(lhs: Int, rhs: Int) -> (Int,Int) {
//    return (lhs,rhs)
//}
//func promote(lhs: Float, rhs: Float) -> (Float,Float) {
//    return (lhs,rhs)
//}
//func promote(lhs: Double, rhs: Double) -> (Double,Double) {
//    return (lhs,rhs)
//}
//
//func promote(lhs: Int, rhs: Float) -> (Float,Float) {
//    return (Float(lhs),rhs)
//}
//func promote(lhs: Float, rhs: Int) -> (Float,Float) {
//    return (lhs,Float(rhs))
//}
//
//func promote(lhs: Int, rhs: Double) -> (Double,Double) {
//    return (Double(lhs),rhs)
//}
//func promote(lhs: Double, rhs: Int) -> (Double,Double) {
//    return (lhs,Double(rhs))
//}
//
//func promote(lhs: Float, rhs: Double) -> (Double,Double) {
//    return (Double(lhs),rhs)
//}
//func promote(lhs: Double, rhs: Float) -> (Double,Double) {
//    return (lhs,Double(rhs))
//}



