extension Matrix {
    func contaminate() {
        _productOfElementary = nil
        _rowEchelon = nil
        _determinant = nil
        _inverted = nil
        _transposed = nil
        fullyInverted = false
        lu = false
    }
}
