import SwiftUI
import NetworkExtension

struct ContentView: View {
    @State private var isOn = false

    var body: some View {
        VStack {
            Toggle(isOn: $isOn) {
                Text(isOn ? "Disconnect" : "Connect")
            }
            .padding()
            .onChange(of: isOn) { value in
                if value {
                    startTunnel()
                } else {
                    stopTunnel()
                }
            }
        }
    }

    private func startTunnel() {
        let manager = NETunnelProviderManager.shared()
        manager.loadFromPreferences { error in
            guard error == nil else { return }
            manager.connection.startVPNTunnel()
        }
    }

    private func stopTunnel() {
        let manager = NETunnelProviderManager.shared()
        manager.connection.stopVPNTunnel()
    }
}
