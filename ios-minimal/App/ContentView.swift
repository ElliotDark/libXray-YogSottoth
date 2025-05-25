import SwiftUI
import Combine

struct ContentView: View {
    @State private var urlText = ""
    @State private var status = ""
    @State private var imported = false
    private let connector = XrayConnector()
    @State private var cancellable: AnyCancellable?

    var body: some View {
        VStack(spacing: 16) {
            TextField("Configuration URL", text: $urlText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Import") { importConfig() }
                .disabled(urlText.isEmpty)
            Button("Connect") { connect() }
                .disabled(!imported)
            Text(status).foregroundColor(.gray)
        }
        .padding()
    }

    private func importConfig() {
        guard let url = URL(string: urlText) else {
            status = "Invalid URL"
            return
        }
        cancellable = ConfigDownloader.download(from: url)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    if case .failure = completion { status = "Download Error" }
                },
                receiveValue: { data in
                    do {
                        try connector.loadConfig(from: data)
                        status = "Config imported"
                        imported = true
                    } catch {
                        status = "Invalid config"
                    }
                }
            )
    }

    private func connect() {
        status = connector.connect()
    }
}
