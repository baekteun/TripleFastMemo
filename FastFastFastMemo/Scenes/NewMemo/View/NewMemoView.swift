import SwiftUI

struct NewMemoView: View {
    @Environment(\.dismiss) var dismiss
    @FocusState var isFocused: Bool
    @StateObject var container: MVIContainer<NewMemoIntentProtocol, NewMemoStateProtocol>
    private var intent: any NewMemoIntentProtocol { container.intent }
    private var state: any NewMemoStateProtocol { container.model }

    var body: some View {
        VStack {
            VStack {
                TextEditor(text: Binding(
                    get: { state.content }, set: intent.contentChanged(content:)
                ))
                .overlay {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.black)
                }
                .focused($isFocused)

                Spacer()

                Button {
                    intent.saveButtonDidTap()
                } label: {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.black)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 54)
                .overlay {
                    Text("저장")
                        .foregroundColor(.white)
                }
                .contentShape(RoundedRectangle(cornerRadius: 4))
            }
            .padding(8)
        }
        .onAppear {
            isFocused = true
        }
        .onChange(of: state.isSuccessSave) { newValue in
            if newValue {
                dismiss()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
