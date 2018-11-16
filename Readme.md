# TrixKit
A matrix library written in Swift. I wrote this as a project for a linear algebra course and it just happens to be a (very) competent terminal calculator.

TrixKit tries to levarage two modes of operation, **safe** and **unsafe**, so it can be used in either a REPL as a linear algebra or in a product as a library.
* However, as TrixKit uses heavy reference semantics, it is not recommended at all in a produciton environment. I may update this in the future but let's be honest, it is probably not going to happen.

In an attempt to keep all my math-related Swift under one roof, TrixKit also has some digital signal processing functions under the `DSP` namespace.

# Examples
## Matrix Multiplication
```swift
    //safe
    guard let a = Matrix([
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9.0]
    ]) else {
        print("Malformed matrix.")
        return
    }
    let b = [[9, 8, 7], [6, 5, 4], [3, 2, 1]].asMatrix //unsafe

    // safe
    if let c = a &* b {
        print(c)
    } else {
        print("Mismatched matrix sizes.")
    }
    // unsafe
    let d = a * b
```

## Determinant
```swift
    // safe
    if let determinant = b.determinant {
        print (determinant)
    }

    print(b.dt) // unsafe
```

## Solution of a system of linear equations
```swift
    let k = [
        [4%, √Double.e],
        [4%, √Double.e]
    ].asMatrix // Clearly showing off some operator overloading

    let solution = k.solve(for: [1, 8])

    switch (solution) {
        case .inconsistent:
            print("Inconsistent system.")
        case .infinite:
            print("Infinitely many solutions.")
        default:
            print(solution.value!)
    }
```

## Row/Column operations
```swift
    let l: Matrix = b.rows[1].asRow
    let m: Matrix = a.columns[0].asColumn

    print(l * m)

    let n = b.rows[2].fastFourierTransform()
```

# Requirements
Swift 4.2. Tested on macOS. Should theoretically be functional with other versions of Swift, however, I avoided all macOS-only code.

## Installing
### macOS
Swift 4.2 is available with Xcode 10.

# Usage
## macOS
Run `./install`. This will build and install TrixKit for your user and allow you to run it in the Terminal by writing trix, where it will run the Swift REPL for you. (You still have to `import TrixKit` though.)

# License
Apache 2.0. Check 'License'.