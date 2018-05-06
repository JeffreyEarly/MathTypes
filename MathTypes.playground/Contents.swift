//: # Math types for Swift
//: The MathTypes creates real and complex number systems for integer and floating point types that can be used in a way consistent with the expectations of scientific programmers. The style and usage attempts to be familiar to regular users of Julia or Matlab.
//:
//: Make all integer literals map to `RealInt` and floating point literals map to `RealFloat`.
import MathTypes
typealias IntegerLiteralType = RealInt
typealias FloatLiteralType = RealDouble
//: Try addition, substraction, multiplication
let a = 1.0
let c = a * im
let b : Imaginary<Int> = 2
let d = c + b

//let e = [a,c]
let e : Array<Int> = [1,2]

//let a = 2*im
//let b = 1 + a
//
//let c = b*im
//let d = c*c
////: Division of a ```RealInt``` gives you a ```RealDouble```
//let e = 1 / 2
////: Multiply a ```RealDouble``` by ```im``` (an ```ImaginaryInt```) and it does the right thing.
//let f = 1.0
//let g = f*im




//let e = abs(d)



