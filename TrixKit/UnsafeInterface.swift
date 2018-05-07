extension Matrix {
    
    public static func *(left: Matrix, right: Matrix) -> Matrix {
        return (left &* right)!
    }
    
    public var l: Matrix {
        return lowerTriangular!
    }
    
    public var u: Matrix {
        return upperTriangular!
    }
    
    public var inv: Matrix {
        return inverted!
    }
    
    public var dt: Real {
        return determinant!
    }
}
