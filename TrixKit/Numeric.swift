import Foundation

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
}
