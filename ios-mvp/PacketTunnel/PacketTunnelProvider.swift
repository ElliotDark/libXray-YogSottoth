import NetworkExtension

class PacketTunnelProvider: NEPacketTunnelProvider {
    private var isRunning = false

    override func startTunnel(options: [String : NSObject]?, completionHandler: @escaping (Error?) -> Void) {
        guard let configPath = (protocolConfiguration as? NETunnelProviderProtocol)?.providerConfiguration?["configPath"] as? String,
              let datDir = (protocolConfiguration as? NETunnelProviderProtocol)?.providerConfiguration?["datDir"] as? String else {
            completionHandler(NSError(domain: "LibXray", code: -1, userInfo: [NSLocalizedDescriptionKey: "Missing configuration"]))
            return
        }

        let request: [String: String] = [
            "datDir": datDir,
            "configPath": configPath
        ]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: request),
              let base64 = jsonData.base64EncodedString().cString(using: .utf8) else {
            completionHandler(NSError(domain: "LibXray", code: -2, userInfo: [NSLocalizedDescriptionKey: "Invalid request"]))
            return
        }

        if let resultPtr = CGoRunXray(base64) {
            let result = String(cString: resultPtr)
            // handle error if needed
            _ = result
        }
        isRunning = true
        completionHandler(nil)
    }

    override func stopTunnel(with reason: NEProviderStopReason, completionHandler: @escaping () -> Void) {
        if isRunning {
            if let resultPtr = CGoStopXray() {
                let result = String(cString: resultPtr)
                _ = result
            }
            isRunning = false
        }
        completionHandler()
    }
}
