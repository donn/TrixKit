import Foundation

prefix operator √
prefix operator ≈

postfix operator %

infix operator **: BitwiseShiftPrecedence
infix operator &**: BitwiseShiftPrecedence
infix operator ∑: BitwiseShiftPrecedence

extension Int {
    public var u: UInt {
        return UInt(bitPattern: self)
    }
    public var f: Float {
        return Float(self)
    }
}

extension Double {
    static public var e: Double {
        return M_E
    }
    static public var π: Double {
        return Double.pi
    }
}

public prefix func ≈<Real: FloatingPoint>(input: Real) -> Real {
    let magnitude = (input < 0) ? -input : input
    return (magnitude > Real.ulpOfOne) ? magnitude : Real(0)
}

public postfix func %<Real: FloatingPoint>(input: Real) -> Real {
    return input / Real(100)
}

public prefix func √<Real: FloatingPoint>(input: Real) -> Real {
    return input.squareRoot()
}

public func **(left: Double, right: Double) -> Double {
    return Foundation.pow(left, right)
}

public func **(left: Float, right: Float) -> Float {
    return Foundation.pow(left, right)
}

public func quadraticSolution<Real: FloatingPoint>(a: Real, b: Real, c: Real) -> (s1: (real: Real, imaginary: Real), s2: (real: Real, imaginary: Real)) {
    let discriminant = b * b - 4 * a * c
    var s1: (real: Real, imaginary: Real) = (real: 0, imaginary: 0)
    var s2: (real: Real, imaginary: Real) = (real: 0, imaginary: 0)
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
