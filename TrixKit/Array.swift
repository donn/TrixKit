import Foundation

extension Array where Iterator.Element: Sequence, Iterator.Element.Element: FloatingPoint {
    public var asMatrix: Matrix<Iterator.Element.Element> {
        return Matrix<Iterator.Element.Element>(self as! ([[Iterator.Element.Element]]))!
    }
}

extension Array where Iterator.Element: Sequence, Iterator.Element.Element == Int {
    public var asMatrix: Matrix<Double> {
        return Matrix<Double>(self.map { $0.map { Double($0) } })!
    }
}

// Vector Operations
extension Array where Iterator.Element: FloatingPoint {
    public typealias Real = Iterator.Element
    
    public func dot(_ right: [Real]) -> Real {
        return zip(self, right).map(*).reduce(0, +)
    }
    
    public var norm: Real {
        return √self.dot(self)
    }
     
    public var unit: [Real] {
        return self.map { $0 / self.norm }
    }
    
    public func distance(to right: [Real]) -> Real {
        return zip(self, right).map(-).norm
    }
    
    public func project(onto right: [Real]) -> [Real] {
        let top = self.dot(right)
        let bottom = right.dot(right)
        return right.map { top / bottom * $0 }
    }
    
    public var asColumn: Matrix<Real> {
        return Matrix<Real>(self.map { [$0] })!
    }
    
    public var asRow: Matrix<Real> {
        return Matrix<Real>([self])!
    }
}

extension Array where Iterator.Element == Double {
    public func angle(to right: [Double]) -> Double {
        return acos(abs(self.dot(right)) / (self.norm * right.norm))
    }
    
    public func discreteFourierTransform() -> (real: [Double], imaginary: [Double]){
        return DSP.discreteFourierTransform(samples: self)
    }
    
    public func fastFourierTransform() -> (real: [Double], imaginary: [Double]) {
        return DSP.fastFourierTransform(samples: self)
    }
    
    public func windowedFastFourierTransform(with window: (_ n: Int, _ N: Int) -> (Double)) -> (real: [Double], imaginary: [Double]) {
        return DSP.windowedFastFourierTransform(samples: self, with: window)
    }
}
