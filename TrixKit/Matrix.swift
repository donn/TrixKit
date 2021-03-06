import Foundation

public class Matrix<Real: FloatingPoint>: CustomStringConvertible {

    var store: [[Real]]
    
    //Calculation Group 0
    var _determinant: Real?
    var _productOfElementary: Matrix?
    var _rowEchelon: Matrix?
    var lu: Bool = false
    
    //Calculation Group 1
    var fullyInverted: Bool = false
    var _inverted: Matrix?
    
    //Calculated Alone
    var _transposed: Matrix?
    
    private init(_ array: [[Real]], checked: Bool = true) {
        self.store = array
    }
    
    convenience public init?(_ array: [[Real]]) {
        let column = array[0].count
        
        for vector in array {
            if vector.count != column {
                return nil
            }
        }
        
        self.init(array, checked: true)
    }
    
    convenience public init?(shape: (rows: Int, columns: Int), array: [Real]) {
        if array.count != shape.rows * shape.columns {
            return nil
        }
        var store: [[Real]] = []
        for i in 0..<shape.rows {
            var row: [Real] = []
            for j in 0..<shape.columns {
                row.append(array[i * shape.rows + j])
            }
            store.append(row)
        }
        self.init(store, checked: true)
    }
    
    public subscript(i: Int, j: Int) -> Real {
        get {
            return store[i][j]
        }
        set(value) {
            contaminate()
            store[i][j] = value
        }
    }
    
    public var description: String {
        var string = "[\n"
        
        for i in 0..<store.count {
            string += "    "
            for j in 0..<store[0].count {
                string += String(describing: self[i, j])
                string += ", "
            }
            string += "\n"
        }
        
        return string + "]"
    }
    
    public static func identity(_ n: Int) -> Matrix {
        var matrix = [[Real]](repeatElement([Real](repeatElement(Real(0), count: n)), count: n))
        
        for diagonal in 0..<n {
            matrix[diagonal][diagonal] = Real(1)
        }
        
        return Matrix(matrix)!
    }
    
    public static func flippedIdentity(_ n: Int) -> Matrix {
        var matrix = [[Real]](repeatElement([Real](repeatElement(Real(0), count: n)), count: n))
        
        for diagonal in 0..<n {
            matrix[diagonal][n - 1 - diagonal] = Real(1)
        }
        
        return Matrix(matrix)!
        
    }
}
