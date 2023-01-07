import SwiftUI

struct MemoListView: View {
    @FocusState var isFocused: Bool
    @StateObject var container: MVIContainer<MemoListIntentProtocol, MemoListStateProtocol>
    private var intent: any MemoListIntentProtocol { container.intent }
    private var state: any MemoListStateProtocol { container.model }
    
    @AppStorage(UserDefaultsKeys.x.rawValue, store: .standard) var xOffset: Int = 0
    @AppStorage(UserDefaultsKeys.y.rawValue, store: .standard) var yOffset: Int = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    if state.isOnNewMemo {
                        TextField("새로운 메모", text: Binding(
                            get: { state.newText }, set: intent.newTextChanged(new:))
                        )
                        .onSubmit {
                            withAnimation {
                                intent.submitNewMemo(content: state.newText)
                            }
                        }
                        .focused($isFocused)
                        .frame(height: 36)
                        .padding(4)
                        .overlay {
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.black)
                        }
                        .padding(.horizontal, 16)
                        .onAppear {
                            isFocused = true
                        }
                    }

                    List(state.memoList, id: \.id) { memo in
                        MemoRowView(memo: memo)
                            .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                Button("복사") {
                                    UIPasteboard.general.string = memo.content
                                }
                                .tint(.gray)
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button("삭제") {
                                    withAnimation {
                                        intent.onDeleteMemo(id: memo.id)
                                    }
                                }
                                .tint(.red)

                                Button("보관") {
                                    withAnimation {
                                        intent.onBoxingMemo(id: memo.id)
                                    }
                                }
                                .tint(.gray)
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

                VStack {
                    Spacer()

                    HStack {
                        Spacer()

                        memoFABButton {
                            if state.isOnNewMemo {
                                intent.submitNewMemo(content: state.newText)
                            }
                            intent.toggleNewMemo(toggle: !state.isOnNewMemo)
                        }
                    }
                }
            }
            .onAppear(perform: intent.onAppear)
            .navigationTitle("메모")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        MemoLockerView.build()
                    } label: {
                        Text("보관함")
                    }
                }
            }
            .fffToast(
                isShowing: Binding(
                    get: { state.isPresentedToast },
                    set: { _ in intent.dismissToToast() }
                ),
                message: state.toastMessage,
                style: .success
            )
        }
        .navigationViewStyle(.stack)
        .onOpenURL { url in
            guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                return
            }
            let parser = MemoListDeepLinkParser {
                intent.toggleNewMemo(toggle: true)
            }

            guard parser.canHandleDeepLink(components) else { return }
            parser.handleDeepLink(components)
        }
    }

    @ViewBuilder
    func memoFABButton(action: @escaping () -> Void) -> some View {
        let dragGesture = DragGesture()
            .onChanged { value in
                xOffset = Int(value.location.x)
                yOffset = Int(value.location.y)
            }
            .onEnded { value in
                xOffset = Int(value.location.x)
                yOffset = Int(value.location.y)
            }

        let longPressGesture = LongPressGesture(minimumDuration: 0.3)
        
        let combindGesture = longPressGesture.sequenced(before: dragGesture)

        Button(action: action) {
            Image(systemName: "plus")
                .foregroundColor(.white)
                .frame(width: 64, height: 64)
                .background {
                    Color.black
                }
                .clipShape(Circle())
                .padding(24)
        }
        .if(xOffset != 0 && yOffset != 0) {
            $0.position(x: CGFloat(xOffset), y: CGFloat(yOffset))
        }
        .simultaneousGesture(combindGesture)
    }
}
