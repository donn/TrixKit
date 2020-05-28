# TrixKit
A matrix library written in Swift. I wrote this as a project for a linear algebra course and it just happens to be a (very) competent terminal calculator.

TrixKit tries to levarage two modes of operation, **safe** and **unsafe**, so it can be used in either a REPL as a linear algebra or in a product as a library.
* However, as TrixKit uses heavy reference semantics, it is not recommended at all in a produciton environment. I may update this in the future but let's be honest, it is probably not going to happen.

If you need an actual, production-ready Linear Algebra library for Swift: [LANumerics](https://github.com/phlegmaticprogrammer/LANumerics) looks extremely promising.

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
Swift 4.2. Tested on macOS. Should theoretically be functional with other versions of Swift, however, as I avoided all macOS-only code.

### macOS
Swift 4.2 is available with Xcode 10.


# Installation
Short version if you're into curling scripts without reading them: `curl https://raw.githubusercontent.com/donn/TrixKit/master/download | sh`.

This will clone the repository, build TrixKit, copy a short script named trix to your user's `bin` folder, then delete the clone.

To uninstall TrixKit, just invoke `trix uninstall` in the terminal.

# Usage in the Terminal
## macOS
Run `trix`, then type `import TrixKit` then press return. You're ready to go.

Still figuring out how to use it in Playgrounds. Why is it so messy?

# License
Apache 2.0. Check 'License'.
