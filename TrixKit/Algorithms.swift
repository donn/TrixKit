extension Matrix {
    func gauss() -> (rowEchelon: [[Real]], productOfElementary: [[Real]], semiInverted: [[Real]]?, lu: Bool) {
        var upper = store
        var lower = Matrix.identity(rows.count).store //Elementary ROW operations: only need rows.count
        var inverted = squareMatrix ? Matrix.identity(rows.count).store : nil
        var lu = squareMatrix
        let minimum = min(rows.count, columns.count)
        
        columnIteration: for i in 0..<minimum {
            var pivot = i
            pivotSearch: while ≈upper[i][pivot] == 0 {
                for k in i..<rows.count {
                    if ≈upper[k][pivot] != 0 {
                        lu = false
                        upper.swapAt(i, k)
                        lower[i][i] -= 1
                        lower[i][k] += 1
                        lower[k][i] += 1
                        lower[k][k] -= 1
                        inverted?.swapAt(i, k)
                        break pivotSearch
                    }
                    if k == rows.count - 1 {
                        pivot += 1
                    }
                    if pivot >= columns.count { //No pivot in this column
                        continue columnIteration
                    }
                }
            }
            rowIteration: for k in (i + 1)..<rows.count {
                if ≈upper[k][pivot] == 0 {
                    continue
                }
                
                let factor = upper[k][pivot] / upper[i][pivot]
                lower[k][i] = factor
                
                for l in 0..<columns.count {
                    upper[k][l] -= upper[i][l] * factor
                    if let scalar = inverted?[i][l] {
                        inverted?[k][l] -= scalar * factor
                    }
                }
            }
        }
        
        return (upper, lower, inverted, lu)
    }
    
    func jordan() -> [[Real]] {
        
        var rowEchelon = self._rowEchelon!.store
        var inverted: [[Real]] = self._inverted!.store
        
        if (fullyInverted) { //Avoid multiple jordans
            return inverted
        }
        
        for k in 0..<rows.count {
            let factor = rowEchelon[k][k]
            for l in 0..<columns.count {
                rowEchelon[k][l] /= factor
                inverted[k][l] /= factor
            }
        }
        
        for i in stride(from: rows.count - 1, through: 0, by: -1) {
            for k in stride(from: i - 1, through: 0, by: -1) {
                let factor = rowEchelon[k][i]
                
                for l in stride(from: columns.count - 1, through: 0, by: -1) {
                    rowEchelon[k][l] -= rowEchelon[i][l] * factor
                    inverted[k][l] -= inverted[i][l] * factor
                }
            }
        }
        
        return inverted
    }
}
