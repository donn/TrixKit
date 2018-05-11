import Foundation

prefix operator √

infix operator **: BitwiseShiftPrecedence

public prefix func √<Real: FloatingPoint>(input: Real) -> Real {
    return input.squareRoot()
}

public func **(left: Double, right: Double) -> Double {
    return Foundation.pow(left, right)
}

public func **(left: Float, right: Float) -> Float {
    return Foundation.pow(left, right)
}

public func **(left: Int, right: Int) -> Int {
    return Int(Foundation.pow(Double(left), Double(right)))
}


public struct Complex<Real: FloatingPoint> {
    var real: Real = 0
    var imaginary: Real = 0
}

public func quadraticSolution<Real: FloatingPoint>(a: Real, b: Real, c: Real) -> (s1: Complex<Real>, s2: Complex<Real>) {
    let discriminant = b * b - 4 * a * c
    var s1 = Complex<Real>()
    var s2 = Complex<Real>()
    s1.real = -b / (2 * a)
    s2.real = s1.real
    if (discriminant < 0) {
        s1.imaginary = √(-discriminant) / (2 * a)
        s2.imaginary = -s1.imaginary
    } else {
        s1.real += √(discriminant) / (2 * a)
        s2.real -= √(discriminant) / (2 * a)
    }
    return (s1, s2)
}
