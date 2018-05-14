import Cocoa
import TrixKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        print([[2, 2, -3, 1, 13], [1, 1, 1, 1, -1], [3, 3, -5, 0, 14], [6, 6, -2, 4, 16]].asMatrix.rowEchelon)
    }
}
