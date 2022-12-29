import SwiftUI

struct MemoLockerView: View {
    @StateObject var container: MVIContainer<MemoLockerIntentProtocol, MemoLockerStateProtocol>
    private var intent: any MemoLockerIntentProtocol { container.intent }
    private var state: any MemoLockerStateProtocol { container.model }

    var body: some View {
        Text("Hello, World!")
    }
}

struct MemoLockerView_Previews: PreviewProvider {
    static var previews: some View {
        MemoLockerView.build()
    }
}
