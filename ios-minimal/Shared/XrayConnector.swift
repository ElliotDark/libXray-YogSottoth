import Foundation

final class XrayConnector {
    private var configPath: String?

    func loadConfig(from data: Data) throws {
        // Validate JSON
        _ = try JSONSerialization.jsonObject(with: data)
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("config.json")
        try data.write(to: url)
        configPath = url.path
    }

    func connect(datDir: String = "") -> String {
        guard let path = configPath else { return "No configuration" }
        let request = ["datDir": datDir, "configPath": path]
        guard let json = try? JSONSerialization.data(withJSONObject: request),
              let base64 = json.base64EncodedString().cString(using: .utf8),
              let resultPtr = CGoRunXray(base64) else {
            return "Run failed"
        }
        let result = String(cString: resultPtr)
        return result.isEmpty ? "Connected" : result
    }
}
