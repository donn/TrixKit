extension Matrix {
    
    public var l: Matrix {
        return lowerTriangular!
    }
    
    public var u: Matrix {
        return upperTriangular!
    }
    
    public var inv: Matrix {
        return inverted!
    }
    
    public var t: Matrix {
        return transposed
    }

    public var re: Matrix {
        return rowEchelon
    }
    
    public var dt: Real {
        return determinant!
    }

    // Multiplication
    
    public static func *(left: Real, right: Matrix) -> Matrix {
        return (left &* right)
    }
    
    public static func *(left: Matrix, right: Matrix) -> Matrix {
        return (left &* right)!
    }

    public static func **(left: Matrix, right: Int) -> Matrix {
        return (left &** right)!
    }

    public static func +(left: Matrix, right: Matrix) -> Matrix {
        return (left &+ right)!
    }

    public static func -(left: Matrix, right: Matrix) -> Matrix {
        return (left &- right)!
    }
}
