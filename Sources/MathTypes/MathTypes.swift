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

public let im : ImaginaryInt = 1

// Note that the requirement T.Stride == T implies T:SignedNumeric.
public struct Real<T> where T:Strideable, T.Stride == T {
    public var raw : T
    
    public init(_ real: T) {
        self.raw = real
    }
}

public struct Imaginary<T> where T:Strideable, T.Stride == T {
    public var raw : T
    
    public init(_ imag: T) {
        self.raw = imag
    }
}

public struct Complex<T> where T:Strideable, T.Stride == T {
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

// We will all the major binary operations on these types with each other. That means each binary operation will have six cases to consider: n*(n-1) with the extra factor of 2 from reversing the order of the operands.

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

extension Real : Numeric {
    public var magnitude: T.Magnitude {
        return self.raw.magnitude
    }
    
    public init?<U>(exactly source: U) where U : BinaryInteger {
        guard let t = T(exactly: source) else { return nil }
        self.raw = t
    }
    
    public static func + (lhs: Real, rhs: Real) -> Real {
        var lhs = lhs
        lhs += rhs
        return lhs
    }
    
    public static func += (lhs: inout Real, rhs: Real) {
        lhs.raw += rhs.raw
    }
    
    public static func - (lhs: Real, rhs: Real) -> Real {
        var lhs = lhs
        lhs -= rhs
        return lhs
    }
    
    public static func -= (lhs: inout Real, rhs: Real) {
        lhs.raw -= rhs.raw
    }
    
    public static func * (lhs: Real, rhs: Real) -> Real {
        return Real(lhs.raw * rhs.raw)
    }
    
    public static func *= (lhs: inout Real, rhs: Real) {
        lhs = lhs * rhs
    }
}

extension Real : SignedNumeric {
    public static prefix func - (operand: Real) -> Real {
        return Real(-operand.raw)
    }
    
    public mutating func negate() {
        raw.negate()
    }
}


extension Real : Comparable {
    public static func < (lhs: Real, rhs: Real) -> Bool {
        return lhs.raw < rhs.raw
    }
    
    public static func > (lhs: Real, rhs: Real) -> Bool {
        return lhs.raw > rhs.raw
    }
    
    public static func <= (lhs: Real, rhs: Real) -> Bool {
        return lhs.raw <= rhs.raw
    }
    
    public static func >= (lhs: Real, rhs: Real) -> Bool {
        return lhs.raw >= rhs.raw
    }
}

extension Real : Strideable {
    public func distance(to other: Real) -> Real {
        return Real(self.raw.distance(to: other.raw))
    }
    
    public func advanced(by amount: Real) -> Real {
        return Real(self.raw.advanced(by: amount.raw))
    }
}


//===----------------------------------------------------------------------===//
// MARK: - Imaginary protocol conformance
//===----------------------------------------------------------------------===//

extension Imaginary : ExpressibleByIntegerLiteral {
    public init(integerLiteral value: T.IntegerLiteralType) {
        self.raw = T.init(integerLiteral: value)
    }
}

extension Imaginary : CustomStringConvertible {
    public var description: String {
        return "\(self.raw)i"
    }
}

extension Imaginary : Equatable {
    public static func == (lhs: Imaginary, rhs: Imaginary) -> Bool {
        return lhs.raw == rhs.raw
    }
}

// This is an incomplete implemention of SignedNumeric because multiplication is missing
extension Imaginary  {
    public var magnitude: T.Magnitude {
        return self.raw.magnitude
    }
    
    public init?<U>(exactly source: U) where U : BinaryInteger {
        guard let t = T(exactly: source) else { return nil }
        self.raw = t
    }
    
    public static func + (lhs: Imaginary, rhs: Imaginary) -> Imaginary {
        var lhs = lhs
        lhs += rhs
        return lhs
    }
    
    public static func += (lhs: inout Imaginary, rhs: Imaginary) {
        lhs.raw += rhs.raw
    }
    
    public static func - (lhs: Imaginary, rhs: Imaginary) -> Imaginary {
        var lhs = lhs
        lhs -= rhs
        return lhs
    }
    
    public static func -= (lhs: inout Imaginary, rhs: Imaginary) {
        lhs.raw -= rhs.raw
    }
    
    public static prefix func - (operand: Imaginary) -> Imaginary {
        return Imaginary(-operand.raw)
    }
    
    public mutating func negate() {
        raw.negate()
    }
}

extension Imaginary : Comparable {
    public static func < (lhs: Imaginary, rhs: Imaginary) -> Bool {
        return lhs.raw < rhs.raw
    }
    
    public static func > (lhs: Imaginary, rhs: Imaginary) -> Bool {
        return lhs.raw > rhs.raw
    }
    
    public static func <= (lhs: Imaginary, rhs: Imaginary) -> Bool {
        return lhs.raw <= rhs.raw
    }
    
    public static func >= (lhs: Imaginary, rhs: Imaginary) -> Bool {
        return lhs.raw >= rhs.raw
    }
}

extension Imaginary : Strideable {
    // Imaginary cannot conform to SignedNumeric, so it just uses T.Stride instead of itself.
    public func distance(to other: Imaginary) -> T.Stride {
        return self.raw.distance(to: other.raw)
    }
    
    public func advanced(by amount: T.Stride) -> Imaginary {
        return Imaginary(self.raw.advanced(by: amount))
    }
}

//===----------------------------------------------------------------------===//
// MARK: - Complex protocol conformance
//===----------------------------------------------------------------------===//

extension Complex : ExpressibleByIntegerLiteral {
    public init(integerLiteral value: T.IntegerLiteralType) {
        self.real = Real(integerLiteral: value)
        self.imag = Imaginary(0)
    }
}

extension Complex : CustomStringConvertible {
    public var description: String {
        if self.imag > 0 {
            return "\(self.real)+\(self.imag)"
        } else {
            return "\(self.real)-\(-self.imag)"
        }
    }
}

extension Complex : Equatable {
    public static func == (lhs: Complex, rhs: Complex) -> Bool {
        return lhs.real == rhs.real && lhs.imag == rhs.imag
    }
}

extension Complex : Numeric {
    public var magnitude: T.Magnitude {
        return real.raw.magnitude*real.raw.magnitude + imag.raw.magnitude*imag.raw.magnitude
    }
    
    public init?<U>(exactly source: U) where U : BinaryInteger {
        guard let t = T(exactly: source) else { return nil }
        self.real = Real(t)
        self.imag = Imaginary(0)
    }
    
    public static func + (lhs: Complex, rhs: Complex) -> Complex {
        var lhs = lhs
        lhs += rhs
        return lhs
    }
    
    public static func += (lhs: inout Complex, rhs: Complex) {
        lhs.real += rhs.real
        lhs.imag += rhs.imag
    }
    
    public static func - (lhs: Complex, rhs: Complex) -> Complex {
        var lhs = lhs
        lhs -= rhs
        return lhs
    }
    
    public static func -= (lhs: inout Complex, rhs: Complex) {
        lhs.real -= rhs.real
        lhs.imag -= rhs.imag
    }
    
    public static func * (lhs: Complex, rhs: Complex) -> Complex {
        // truncated form of function in NumericAnnex
        let a = lhs.real.raw, b = lhs.imag.raw, c = rhs.real.raw, d = rhs.imag.raw
        let ac = a * c, bd = b * d, ad = a * d, bc = b * c
        let x = ac - bd
        let y = ad + bc
        return Complex(real: x, imag: y)
    }
    
    public static func *= (lhs: inout Complex, rhs: Complex) {
        lhs = lhs * rhs
    }
}

extension Complex : SignedNumeric {
    public static prefix func - (operand: Complex) -> Complex {
        return Complex(real: -operand.real, imag: -operand.imag)
    }
    
    public mutating func negate() {
        real.negate()
        imag.negate()
    }
}

extension Complex {
    public var squaredMagnitude : Real<T> {
        return Real(real.raw*real.raw + imag.raw*imag.raw);
    }
    
    public var conjugate : Complex<T> {
        return Complex(real: real, imag: -imag)
    }
}

//===----------------------------------------------------------------------===//
// MARK: - Mixed-type (real, imaginary, complex) binary operators
//         We extend the lhs type
//===----------------------------------------------------------------------===//

extension Imaginary  {
    public static func + (lhs: Imaginary, rhs: Real<T>) -> Complex<T> {
        return Complex(real:rhs,imag:lhs)
    }
    
    public static func + (lhs: Imaginary, rhs: Complex<T>) -> Complex<T> {
        return Complex(real:rhs.real,imag:lhs + rhs.imag)
    }
    
    public static func - (lhs: Imaginary, rhs: Real<T>) -> Complex<T> {
        return Complex(real:-rhs,imag:lhs)
    }
    
    public static func - (lhs: Imaginary, rhs: Complex<T>) -> Complex<T> {
        return Complex(real:-rhs.real,imag:lhs - rhs.imag)
    }
    
    public static func * (lhs: Imaginary, rhs: Imaginary) -> Real<T> {
        return Real(-lhs.raw*rhs.raw)
    }
    
    public static func * (lhs: Imaginary, rhs: Real<T>) -> Imaginary {
        return Imaginary(lhs.raw*rhs.raw)
    }
    
    public static func * (lhs: Imaginary, rhs: Complex<T>) -> Complex<T> {
        return Complex(real:-rhs.imag.raw,imag:rhs.real.raw)
    }
}

extension Real  {
    public static func + (lhs: Real, rhs: Imaginary<T>) -> Complex<T> {
        return Complex(real:lhs,imag:rhs)
    }
    
    public static func + (lhs: Real, rhs: Complex<T>) -> Complex<T> {
        return Complex(real:lhs + rhs.real,imag:rhs.imag)
    }
    
    public static func - (lhs: Real, rhs: Imaginary<T>) -> Complex<T> {
        return Complex(real:lhs,imag:-rhs)
    }
    
    public static func - (lhs: Real, rhs: Complex<T>) -> Complex<T> {
        return Complex(real:lhs-rhs.real,imag:-rhs.imag)
    }
    
    public static func * (lhs: Real, rhs: Imaginary<T>) -> Imaginary<T> {
        return Imaginary(lhs.raw*rhs.raw)
    }
    
    public static func * (lhs: Real, rhs: Complex<T>) -> Complex<T> {
        return Complex(real:lhs * rhs.real,imag:lhs * rhs.imag)
    }
}

extension Complex  {
    public static func + (lhs: Complex, rhs: Imaginary<T>) -> Complex<T> {
        return Complex(real:lhs.real,imag:lhs.imag+rhs)
    }
    
    public static func + (lhs: Complex, rhs: Real<T>) -> Complex<T> {
        return Complex(real:lhs.real+rhs,imag:lhs.imag)
    }
    
    public static func - (lhs: Complex, rhs: Imaginary<T>) -> Complex<T> {
        return Complex(real:lhs.real,imag:lhs.imag-rhs)
    }
    
    public static func - (lhs: Complex, rhs: Real<T>) -> Complex<T> {
        return Complex(real:lhs.real-rhs,imag:lhs.imag)
    }
    
    public static func * (lhs: Complex, rhs: Imaginary<T>) -> Complex<T> {
        return Complex(real: -lhs.imag.raw*rhs.raw, imag: lhs.real.raw*rhs.raw)
    }
    
    public static func * (lhs: Complex, rhs: Real<T>) -> Complex<T> {
        return Complex(real: lhs.real*rhs, imag: lhs.imag*rhs)
    }
}

//===----------------------------------------------------------------------===//
// MARK: - FloatingPoint type extentions
//===----------------------------------------------------------------------===//

extension Real where T:FloatingPoint {
    public init(_ real: Int ) {
        self.raw = T(real)
    }
    public init(_ real: RealInt ) {
        self.raw = T(real.raw)
    }
}

extension Real : ExpressibleByFloatLiteral where T : _ExpressibleByBuiltinFloatLiteral {
    public typealias FloatLiteralType = T
    public init(floatLiteral value: T) {
        self.raw = value
    }
}

extension Real where T:FloatingPoint {
    public static func / (lhs: Real, rhs: Real) -> Real {
        var lhs = lhs
        lhs /= rhs
        return lhs
    }
    
    public static func /= (lhs: inout Real, rhs: Real) {
        lhs.raw /= rhs.raw
    }
    
    public static func / (lhs: Real, rhs: Imaginary<T>) -> Imaginary<T> {
        return Imaginary(-lhs.raw/rhs.raw)
    }
    public static func / (lhs: Real, rhs: Complex<T>) -> Complex<T> {
        let mag = rhs.squaredMagnitude
        return Complex(real: lhs.raw*rhs.real.raw/mag.raw, imag: -lhs.raw*rhs.imag.raw/mag.raw)
    }
}

extension Imaginary where T:FloatingPoint {
    public init(_ imag: Int ) {
        self.raw = T(imag)
    }
    public init(_ imag: ImaginaryInt ) {
        self.raw = T(imag.raw)
    }
}

extension Imaginary where T:FloatingPoint {
    public static func / (lhs: Imaginary, rhs: Imaginary) -> Real<T> {
        return Real(lhs.raw/rhs.raw)
    }
    
    public static func / (lhs: Imaginary, rhs: Real<T>) -> Imaginary {
        return Imaginary(lhs.raw/rhs.raw)
    }
    
    public static func / (lhs: Imaginary, rhs: Complex<T>) -> Complex<T> {
        let mag = rhs.squaredMagnitude
        return Complex(real: lhs.raw*rhs.imag.raw/mag.raw, imag: lhs.raw*rhs.real.raw/mag.raw)
    }
}

extension Complex where T:FloatingPoint {
    public init(real: Int, imag: Int) {
        self.real = Real<T>(real)
        self.imag = Imaginary<T>(imag)
    }
    public init(_ complex: ComplexInt) {
        self.real = Real(complex.real)
        self.imag = Imaginary(complex.imag)
    }
}

extension Complex where T:FloatingPoint {
    public static func / (lhs: Complex, rhs: Real<T>) -> Complex {
        return Complex(real: lhs.real/rhs, imag: lhs.imag/rhs)
    }
    
    public static func / (lhs: Complex, rhs: Imaginary<T>) -> Complex {
        return Complex(real: lhs.imag.raw/rhs.raw, imag: -lhs.real.raw/rhs.raw)
    }
    
    public static func / (lhs: Complex, rhs: Complex) -> Complex {
        return (lhs * rhs.conjugate)/rhs.squaredMagnitude
    }
}

//===----------------------------------------------------------------------===//
// MARK: - Integer division
//===----------------------------------------------------------------------===//
// Important note: this is the *one* spot where we must choose the output type. Ideally, the user could somehow override our default precision.

// I would think that this *should* do the exact same thing as the global function below, but it doesn't.
extension Real where T == Int {
    public static func / (lhs: Real, rhs: Real) -> Real<Double> {
        return Real<Double>(lhs.raw)/Real<Double>(rhs.raw)
    }
}

public func / (lhs: Real<Int>, rhs: Real<Int>) -> Real<Double> {
    return Real<Double>(lhs.raw)/Real<Double>(rhs.raw)
}

//===----------------------------------------------------------------------===//
// MARK: - Mixed type (Int, Float, Double) binary operations
//===----------------------------------------------------------------------===//
// Julia has a set of rules to 'promote' types,
//  https://docs.julialang.org/en/stable/manual/conversion-and-promotion/
// It would be great if we could do that too (at minimal cost).

// This is a stupid amount of boilerplate---but I couldn't figure out how to generalize promotion.

extension Real where T == Int {
    public static func < <F>(lhs: Real, rhs: Real<F>) -> Bool where F:FloatingPoint, F.Stride == F {
        return Real<F>(lhs) < rhs
    }
    
    public static func > <F>(lhs: Real, rhs: Real<F>) -> Bool where F:FloatingPoint, F.Stride == F {
        return Real<F>(lhs) > rhs
    }
    
    public static func <= <F>(lhs: Real, rhs: Real<F>) -> Bool where F:FloatingPoint, F.Stride == F {
        return Real<F>(lhs) <= rhs
    }
    
    public static func >= <F>(lhs: Real, rhs: Real<F>) -> Bool where F:FloatingPoint, F.Stride == F {
        return Real<F>(lhs) >= rhs
    }
    
    // Now do the operand raw-type mirror image of the above
    public static func < <F>(lhs: Real<F>, rhs: Real) -> Bool where F:FloatingPoint, F.Stride == F {
        return lhs < Real<F>(rhs)
    }
    
    public static func > <F>(lhs: Real<F>, rhs: Real) -> Bool where F:FloatingPoint, F.Stride == F {
        return lhs > Real<F>(rhs)
    }
    
    public static func <= <F>(lhs: Real<F>, rhs: Real) -> Bool where F:FloatingPoint, F.Stride == F {
        return lhs <= Real<F>(rhs)
    }
    
    public static func >= <F>(lhs: Real<F>, rhs: Real) -> Bool where F:FloatingPoint, F.Stride == F {
        return lhs >= Real<F>(rhs)
    }
}

extension Real where T == Int  {
    public static func + <F>(lhs: Real, rhs: Real<F>) -> Real<F> where F:FloatingPoint, F.Stride == F {
        return Real<F>(lhs) + rhs
    }
    
    public static func + <F>(lhs: Real, rhs: Imaginary<F>) -> Complex<F> where F:FloatingPoint, F.Stride == F {
        return Real<F>(lhs) + rhs
    }
    
    public static func + <F>(lhs: Real, rhs: Complex<F>) -> Complex<F> where F:FloatingPoint, F.Stride == F {
        return Real<F>(lhs) + rhs
    }

    public static func - <F>(lhs: Real, rhs: Real<F>) -> Real<F> where F:FloatingPoint, F.Stride == F {
        return Real<F>(lhs) - rhs
    }
    
    public static func - <F>(lhs: Real, rhs: Imaginary<F>) -> Complex<F> where F:FloatingPoint, F.Stride == F {
        return Real<F>(lhs) - rhs
    }
    
    public static func - <F>(lhs: Real, rhs: Complex<F>) -> Complex<F> where F:FloatingPoint, F.Stride == F {
        return Real<F>(lhs) - rhs
    }

    public static func * <F>(lhs: Real, rhs: Real<F>) -> Real<F> where F:FloatingPoint, F.Stride == F {
        return Real<F>(lhs) * rhs
    }
    
    public static func * <F>(lhs: Real, rhs: Imaginary<F>) -> Imaginary<F> where F:FloatingPoint, F.Stride == F {
        return Real<F>(lhs) * rhs
    }
    
    public static func * <F>(lhs: Real, rhs: Complex<F>) -> Complex<F> where F:FloatingPoint, F.Stride == F {
        return Real<F>(lhs) * rhs
    }
    
    public static func / <F>(lhs: Real, rhs: Real<F>) -> Real<F> where F:FloatingPoint, F.Stride == F {
        return Real<F>(lhs) / rhs
    }
    
    public static func / <F>(lhs: Real, rhs: Imaginary<F>) -> Imaginary<F> where F:FloatingPoint, F.Stride == F {
        return Real<F>(lhs) / rhs
    }
    
    public static func / <F>(lhs: Real, rhs: Complex<F>) -> Complex<F> where F:FloatingPoint, F.Stride == F {
        return Real<F>(lhs) / rhs
    }
    
    // Now do the operand raw-type mirror image of the above
    public static func + <F>(lhs: Real<F>, rhs: Real<T>) -> Real<F> where F:FloatingPoint, F.Stride == F {
        return lhs + Real<F>(rhs)
    }
    
    public static func + <F>(lhs: Real<F>, rhs: Imaginary<T>) -> Complex<F> where F:FloatingPoint, F.Stride == F {
        return lhs + Imaginary<F>(rhs)
    }
    
    public static func + <F>(lhs: Real<F>, rhs: Complex<T>) -> Complex<F> where F:FloatingPoint, F.Stride == F {
        return lhs + Complex<F>(rhs)
    }

    public static func - <F>(lhs: Real<F>, rhs: Real<T>) -> Real<F> where F:FloatingPoint, F.Stride == F {
        return lhs - Real<F>(rhs)
    }
    
    public static func - <F>(lhs: Real<F>, rhs: Imaginary<T>) -> Complex<F> where F:FloatingPoint, F.Stride == F {
        return lhs - Imaginary<F>(rhs)
    }
    
    public static func - <F>(lhs: Real<F>, rhs: Complex<T>) -> Complex<F> where F:FloatingPoint, F.Stride == F {
        return lhs - Complex<F>(rhs)
    }
    
    public static func * <F>(lhs: Real<F>, rhs: Real<T>) -> Real<F> where F:FloatingPoint, F.Stride == F {
        return lhs * Real<F>(rhs)
    }
    
    public static func * <F>(lhs: Real<F>, rhs: Imaginary<T>) -> Imaginary<F> where F:FloatingPoint, F.Stride == F {
        return lhs * Imaginary<F>(rhs)
    }
    
    public static func * <F>(lhs: Real<F>, rhs: Complex<T>) -> Complex<F> where F:FloatingPoint, F.Stride == F {
        return lhs * Complex<F>(rhs)
    }
    
    public static func / <F>(lhs: Real<F>, rhs: Real<T>) -> Real<F> where F:FloatingPoint, F.Stride == F {
        return lhs / Real<F>(rhs)
    }
    
    public static func / <F>(lhs: Real<F>, rhs: Imaginary<T>) -> Imaginary<F> where F:FloatingPoint, F.Stride == F {
        return lhs / Imaginary<F>(rhs)
    }
    
    public static func / <F>(lhs: Real<F>, rhs: Complex<T>) -> Complex<F> where F:FloatingPoint, F.Stride == F {
        return lhs / Complex<F>(rhs)
    }
}

extension Imaginary where T == Int {
    public static func < <F>(lhs: Imaginary, rhs: Imaginary<F>) -> Bool where F:FloatingPoint, F.Stride == F {
        return Imaginary<F>(lhs) < rhs
    }
    
    public static func > <F>(lhs: Imaginary, rhs: Imaginary<F>) -> Bool where F:FloatingPoint, F.Stride == F {
        return Imaginary<F>(lhs) > rhs
    }
    
    public static func <= <F>(lhs: Imaginary, rhs: Imaginary<F>) -> Bool where F:FloatingPoint, F.Stride == F {
        return Imaginary<F>(lhs) <= rhs
    }
    
    public static func >= <F>(lhs: Imaginary, rhs: Imaginary<F>) -> Bool where F:FloatingPoint, F.Stride == F {
        return Imaginary<F>(lhs) >= rhs
    }
    
    // Now do the operand raw-type mirror image of the above
    public static func < <F>(lhs: Imaginary<F>, rhs: Imaginary) -> Bool where F:FloatingPoint, F.Stride == F {
        return lhs < Imaginary<F>(rhs)
    }
    
    public static func > <F>(lhs: Imaginary<F>, rhs: Imaginary) -> Bool where F:FloatingPoint, F.Stride == F {
        return lhs > Imaginary<F>(rhs)
    }
    
    public static func <= <F>(lhs: Imaginary<F>, rhs: Imaginary) -> Bool where F:FloatingPoint, F.Stride == F {
        return lhs <= Imaginary<F>(rhs)
    }
    
    public static func >= <F>(lhs: Imaginary<F>, rhs: Imaginary) -> Bool where F:FloatingPoint, F.Stride == F {
        return lhs >= Imaginary<F>(rhs)
    }
}

extension Imaginary where T == Int {
    
    
    public static func + <F>(lhs: Imaginary, rhs: Imaginary<F>) -> Imaginary<F> where F:FloatingPoint, F.Stride == F {
        return Imaginary<F>(lhs) + rhs
    }
    
    public static func + <F>(lhs: Imaginary, rhs: Real<F>) -> Complex<F> where F:FloatingPoint, F.Stride == F {
        return Imaginary<F>(lhs) + rhs
    }
    
    public static func + <F>(lhs: Imaginary, rhs: Complex<F>) -> Complex<F> where F:FloatingPoint, F.Stride == F {
        return Imaginary<F>(lhs) + rhs
    }
    
    public static func - <F>(lhs: Imaginary, rhs: Imaginary<F>) -> Imaginary<F> where F:FloatingPoint, F.Stride == F {
        return Imaginary<F>(lhs) - rhs
    }
    
    public static func - <F>(lhs: Imaginary, rhs: Real<F>) -> Complex<F> where F:FloatingPoint, F.Stride == F {
        return Imaginary<F>(lhs) - rhs
    }
    
    public static func - <F>(lhs: Imaginary, rhs: Complex<F>) -> Complex<F> where F:FloatingPoint, F.Stride == F {
        return Imaginary<F>(lhs) - rhs
    }
    
    public static func * <F>(lhs: Imaginary, rhs: Imaginary<F>) -> Real<F> where F:FloatingPoint, F.Stride == F {
        return Imaginary<F>(lhs) * rhs
    }
    
    public static func * <F>(lhs: Imaginary, rhs: Real<F>) -> Imaginary<F> where F:FloatingPoint, F.Stride == F {
        return Imaginary<F>(lhs) * rhs
    }
    
    public static func * <F>(lhs: Imaginary, rhs: Complex<F>) -> Complex<F> where F:FloatingPoint, F.Stride == F {
        return Imaginary<F>(lhs) * rhs
    }
    
    public static func / <F>(lhs: Imaginary, rhs: Imaginary<F>) -> Real<F> where F:FloatingPoint, F.Stride == F {
        return Imaginary<F>(lhs) / rhs
    }
    
    public static func / <F>(lhs: Imaginary, rhs: Real<F>) -> Imaginary<F> where F:FloatingPoint, F.Stride == F {
        return Imaginary<F>(lhs) / rhs
    }
    
    public static func / <F>(lhs: Imaginary, rhs: Complex<F>) -> Complex<F> where F:FloatingPoint, F.Stride == F {
        return Imaginary<F>(lhs) / rhs
    }
    
    // Now do the operand raw-type mirror image of the above
    public static func + <F>(lhs: Imaginary<F>, rhs: Imaginary<T>) -> Imaginary<F> where F:FloatingPoint, F.Stride == F {
        return lhs + Imaginary<F>(rhs)
    }
    
    public static func + <F>(lhs: Imaginary<F>, rhs: Real<T>) -> Complex<F> where F:FloatingPoint, F.Stride == F {
        return lhs + Real<F>(rhs)
    }
    
    public static func + <F>(lhs: Imaginary<F>, rhs: Complex<T>) -> Complex<F> where F:FloatingPoint, F.Stride == F {
        return lhs + Complex<F>(rhs)
    }
    
    public static func - <F>(lhs: Imaginary<F>, rhs: Imaginary<T>) -> Imaginary<F> where F:FloatingPoint, F.Stride == F {
        return lhs - Imaginary<F>(rhs)
    }
    
    public static func - <F>(lhs: Imaginary<F>, rhs: Real<T>) -> Complex<F> where F:FloatingPoint, F.Stride == F {
        return lhs - Real<F>(rhs)
    }
    
    public static func - <F>(lhs: Imaginary<F>, rhs: Complex<T>) -> Complex<F> where F:FloatingPoint, F.Stride == F {
        return lhs - Complex<F>(rhs)
    }
    
    public static func * <F>(lhs: Imaginary<F>, rhs: Imaginary<T>) -> Real<F> where F:FloatingPoint, F.Stride == F {
        return lhs * Imaginary<F>(rhs)
    }
    
    public static func * <F>(lhs: Imaginary<F>, rhs: Real<T>) -> Imaginary<F> where F:FloatingPoint, F.Stride == F {
        return lhs * Real<F>(rhs)
    }
    
    public static func * <F>(lhs: Imaginary<F>, rhs: Complex<T>) -> Complex<F> where F:FloatingPoint, F.Stride == F {
        return lhs * Complex<F>(rhs)
    }
    
    public static func / <F>(lhs: Imaginary<F>, rhs: Imaginary<T>) -> Real<F> where F:FloatingPoint, F.Stride == F {
        return lhs / Imaginary<F>(rhs)
    }
    
    public static func / <F>(lhs: Imaginary<F>, rhs: Real<T>) -> Imaginary<F> where F:FloatingPoint, F.Stride == F {
        return lhs / Real<F>(rhs)
    }
    
    public static func / <F>(lhs: Imaginary<F>, rhs: Complex<T>) -> Complex<F> where F:FloatingPoint, F.Stride == F {
        return lhs * Complex<F>(rhs)
    }
}
