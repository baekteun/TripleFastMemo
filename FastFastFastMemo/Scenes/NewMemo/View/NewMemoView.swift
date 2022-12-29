import SwiftUI

struct NewMemoView: View {
    @StateObject var container: MVIContainer<NewMemoIntentProtocol, NewMemoStateProtocol>
    private var intent: any NewMemoIntentProtocol { container.intent }
    private var state: any NewMemoStateProtocol { container.model }

    var body: some View {
        Text("Hello, World!")
    }
}
