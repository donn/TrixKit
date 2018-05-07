import Foundation

prefix operator √

public prefix func √<Real: FloatingPoint>(input: Real) -> Real {
    return input.squareRoot()
}
