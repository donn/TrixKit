import Cocoa
import TrixKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let matrix = Matrix(userInputArray), inverted = matrix.inverted {
            print(inverted)
        } else {
            print("The matrix is either invalid or uninvertible.")
        }
    }
}
