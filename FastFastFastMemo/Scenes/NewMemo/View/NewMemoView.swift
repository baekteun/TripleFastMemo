import SwiftUI

struct NewMemoView: View {
    @StateObject var container: MVIContainer<NewMemoIntentProtocol, NewMemoStateProtocol>
    private var intent: any NewMemoIntentProtocol { container.intent }
    private var state: any NewMemoStateProtocol { container.model }

    var body: some View {
        VStack {
            TextEditor(text: Binding(
                get: { state.content }, set: intent.contentChanged(content:)
            ))
            .overlay {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.black)
            }
            .padding(4)

            Button {
                
            } label: {
                Text("저장")
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.black)
            }
            .padding(4)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
