import SwiftUI

struct MemoLockerView: View {
    @StateObject var container: MVIContainer<MemoLockerIntentProtocol, MemoLockerStateProtocol>
    private var intent: any MemoLockerIntentProtocol { container.intent }
    private var state: any MemoLockerStateProtocol { container.model }

    var body: some View {
        VStack {
            List(state.boxedMemoList, id: \.id) { memo in
                MemoLockerRowView(memo: memo)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button("삭제") {
                            withAnimation {
                                intent.onDelete(id: memo.id)
                            }
                        }
                        .tint(.red)
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .contextMenu {
                        Button {
                            UIPasteboard.general.string = memo.content
                            intent.presentToToast(message: "클립보드에 복사되었습니다!")
                        } label: {
                            Label("복사", systemImage: "list.clipboard.fill")
                        }
                    }
            }
            .listStyle(.plain)
        }
        .onAppear {
            intent.onAppear()
        }
        .fffToast(
            isShowing: Binding(
                get: { state.isPresentedToast },
                set: { _ in intent.dismissToToast() }
            ),
            message: state.toastMessage,
            style: .success
        )
        .navigationTitle("메모 보관함")
    }
}

struct MemoLockerView_Previews: PreviewProvider {
    static var previews: some View {
        MemoLockerView.build()
    }
}
