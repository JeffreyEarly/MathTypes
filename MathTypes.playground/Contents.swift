//: # Math types for Swift
//: The MathTypes creates real and complex number systems for integer and floating point types that can be used in a way consistent with the expectations of scientific programmers. The style and usage attempts to be familiar to regular users of Julia or Matlab.
//:
//: ## Setup the math environment
//: Make all integer literals map to `RealInt` and floating point literals map to `RealFloat`.
import MathTypes
typealias IntegerLiteralType = RealInt
typealias FloatLiteralType = RealFloat
//: ## Try addition, substraction, multiplication
let a = 2*im
let b = 1 + a

let c = b*im
let d = c*c
//: ## Division of a ```RealInt``` gives you a ```RealFloat```
let e = 1 / 2




//let e = abs(d)



