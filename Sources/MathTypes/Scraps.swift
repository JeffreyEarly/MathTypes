//
//  Scraps.swift
//  MathTypes
//
//  Created by Jeffrey Early on 4/26/18.
//

protocol MathType {
    associatedtype RawType: Strideable where RawType.Stride == RawType
    var raw : RawType {get set}
}

//protocol MathFloatingType : MathType where RawType : FloatingPoint {
//    init(_ real: Int)
//    init(_ real: )
//}

protocol Addition : MathType {
    associatedtype OperandT: MathType where Self.RawType == OperandT.RawType
    associatedtype ResultT: MathType where Self.RawType == ResultT.RawType
    static func + (lhs: Self, rhs: OperandT ) -> ResultT
    static func + (lhs: OperandT, rhs: Self ) -> ResultT
}

extension Real : MathType {}
extension Imaginary : MathType {}
extension Real : Addition {
    typealias OperandT = Real<T>
    typealias ResultT = Real<T>
}

protocol AdditionFloatingType : MathType {
    associatedtype OperandFloatT: MathType where OperandFloatT.RawType : FloatingPoint
    associatedtype ResultFloatT: MathType where OperandFloatT.RawType == ResultFloatT.RawType
    static func + (lhs: Self, rhs: OperandFloatT ) -> ResultFloatT
    static func + (lhs: OperandFloatT, rhs: Self ) -> ResultFloatT
}

