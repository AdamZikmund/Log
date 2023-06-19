import SwiftUI
import Log

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Log tap") {
                logTap()
            }
        }
        .padding()
    }

    private func logTap() {
        Log.debug("Tapped on button")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
