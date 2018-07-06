# TrixKit
A matrix library written in Swift.

TrixKit tries to levarage two modes of operation, **safe** and **unsafe**, so it can be used in either a REPL as a linear algebra or in a product as a library.

TrixKit also has some digital signal processing functions under the `DSP` namespace.

# Requirements
Swift 4.1. Tested on macOS, but should also be functional on Linux.

## Installing Dependencies
### macOS
Swift 4.1 is available with Xcode 9.3.

### Debian-based OSes (incl. Ubuntu)
Follow the installation instructions official version of Swift from https://swift.org.

This will need a Swift package manager file but honestly, I'm entirely too lazy at this point. Sorry!

# Usage
## macOS
Build the library using Xcode, then invoke `swift -F <path>`, where the path is to a folder containing TrixKit.framework.

# License
Apache 2.0. Check 'License'.