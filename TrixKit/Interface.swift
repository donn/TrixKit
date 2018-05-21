extension Matrix {
    //Properties/Representations
    public var transposed: Matrix {
        
        if let result = _transposed {
            return result
        }
        
        var result: [[Real]] = []
        
        for i in 0..<store[0].count {
            var row: [Real] = []
            for j in 0..<store.count {
                row.append(self[j, i])
            }
            result.append(row)
        }
        
        _transposed = Matrix(result)
        
        return _transposed!
    }
    
    public var rows: [[Real]] {
        return store
    }
    
    public var columns: [[Real]] {
        return transposed.store
    }
    
    public var squareMatrix: Bool {
        return (rows.count == columns.count)
    }
    
    public var rowEchelon: Matrix {
        if let rowEchelon = _rowEchelon {
            return rowEchelon
        }
        
        let result = gauss()
        
        _rowEchelon = Matrix(result.rowEchelon)!
        _productOfElementary = Matrix(result.productOfElementary)!
        
        if let semiInverted = result.semiInverted {
            _inverted = Matrix(semiInverted)!
        }
        lu = result.lu
        
        return _rowEchelon!
    }
    
    public var determinant: Real? {
        if let determinant = _determinant { //Determinant exists
            return determinant
        }
        if squareMatrix { //Is a square matrix, we can GET the determinant
            _determinant = Real(1)
            for k in 0..<rows.count {
                _determinant! *= rowEchelon.store[k][k]
            }
            return _determinant
        }
        
        return nil //Not a square matrix
    }
    
    public var lowerTriangular: Matrix? {
        if let _ = self.determinant, lu {
            return _productOfElementary!
        }
        return nil
    }
    
    public var upperTriangular: Matrix? {
        if let _ = self.determinant, lu {
            return _rowEchelon!
        }
        return nil
    }
    
    public var inverted: Matrix? {
        if let determinant = self.determinant {
            if fullyInverted { //Exists
                return _inverted
            }
            if determinant != 0 { //Can exist
                _inverted = Matrix(jordan())!
                fullyInverted = true
                return _inverted
            }
        }
        
        return nil
    }
    
    public enum Solution {
        case inconsistent
        case unique
        case infinite
    }
    
    public func solve(for b: [Real]) -> (result: Solution, value: [Real]?) {
        var rowEchelon = self.rowEchelon.store;
        var y = (self._productOfElementary!.inverted! * b.asColumn).columns[0]
        
        if !squareMatrix || determinant == 0 {
            for k in stride(from: rows.count - 1, through: 0, by: -1) {
                var sum = Real(0)
                for l in 0..<columns.count {
                    sum += rowEchelon[k][l]
                }
                if sum == 0 {
                    if y[k] != 0 {
                        return (result: .inconsistent, value: nil)
                    }
                    let _ = (rowEchelon.popLast(), y.popLast())
                }
            }
            
            if rowEchelon.count < rowEchelon[0].count {
                return (result: .infinite, value: nil)
            }
            if rowEchelon.count > rowEchelon[0].count {
                return (result: .inconsistent, value: nil)
            }
        }
        
        return (result: .unique, value: (Matrix(rowEchelon)!.inverted! * y.asColumn).store.map { $0[0] })
    }
    
    public static func &*(left: Matrix, right: Matrix) -> Matrix? {
        if left.columns.count != right.rows.count {
            return nil
        }
        
        let n = left.columns.count
        
        var result: [[Real]] = []
        
        for i in 0..<left.rows.count {
            var row: [Real] = []
            for j in 0..<right.columns.count {
                var element: Real = Real(0)
                for k in 0..<n {
                    element += left.store[i][k] * right.transposed.store[j][k] //right.store[k][j]
                }
                row.append(element)
            }
            result.append(row)
        }
        
        return Matrix(result)!
    }
    
    public static func &**(right: Matrix, left: Int) -> Matrix? {
        if !right.squareMatrix {
            return nil
        }

        var exponent = left

        var matrix: Matrix? = right

        if (exponent < 0) {
            exponent = -exponent
            matrix = right.inverted
        }

        guard let final = matrix else {
            return nil
        }
        
        return (1..<left).reduce(final) {
            (final: Matrix, next: Int) in
            return final * right
        }
        
    }
    
    // Linear Operations
    public static func ==(left: Matrix, right: Matrix) -> Bool {
        if left.rows.count != right.rows.count && left.columns.count != right.columns.count {
            return false
        }
        
        for i in 0..<left.rows.count {
            for j in 0..<left.columns.count {
                if left[i, j] != right[i, j] {
                    return false
                }
            }
        }
        
        return true
    }
    
    public static func !=(left: Matrix, right: Matrix) -> Bool {
        return !(left == right)
    }
    
    // Scalar Operations
    public static func &*(left: Real, right: Matrix) -> Matrix {
        var result = right.store
        for i in 0..<result.count {
            for j in 0..<result[i].count {
                result[i][j] *= left
            }
        }
        return Matrix(result)!
    }

    public static func &+(left: Matrix, right: Matrix) -> Matrix? {
        if left.rows.count != right.rows.count && left.columns.count != right.columns.count {
            return nil
        }

        var result = right.store
        
        for i in 0..<left.rows.count {
            for j in 0..<left.columns.count {
                result[i][j] = left[i, j] + right[i, j]
            }
        }
        
        return Matrix(result)!
    }

    public static func &-(left: Matrix, right: Matrix) -> Matrix? {
        if left.rows.count != right.rows.count && left.columns.count != right.columns.count {
            return nil
        }

        var result = right.store
        
        for i in 0..<left.rows.count {
            for j in 0..<left.columns.count {
                result[i][j] = left[i, j] - right[i, j]
            }
        }
        
        return Matrix(result)!
    }
}

public func identity(_ n: Int) -> Matrix<Double> {
    return Matrix<Double>.identity(n)
}

public func flippedIdentity(_ n: Int) -> Matrix<Double> {
    return Matrix<Double>.flippedIdentity(n)
}
