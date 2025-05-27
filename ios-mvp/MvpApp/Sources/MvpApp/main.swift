import Foundation
import CBridge

if let ptr = CGoXrayVersion() {
    let version = String(cString: ptr)
    print("Xray version: \(version)")
}
