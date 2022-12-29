import SwiftUI

struct MemoListView: View {
    @FocusState var isFocused: Bool
    @StateObject var container: MVIContainer<MemoListIntentProtocol, MemoListStateProtocol>
    private var intent: any MemoListIntentProtocol { container.intent }
    private var state: any MemoListStateProtocol { container.model }
    
    var body: some View {
        NavigationStack {
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
                        memoRowView(memo: memo)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button("삭제") {
                                    withAnimation {
                                        intent.onDeleteMemo(id: memo.id)
                                    }
                                }
                                .tint(.red)

                                Button("보관") {
                                    
                                }
                                .tint(.gray)
                            }
                            .listRowSeparator(.hidden)
                            .listRowInsets(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
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
                            } else {
                                intent.toggleNewMemo(toggle: !state.isOnNewMemo)
                            }
                        }
                    }
                }
            }
            .onAppear(perform: intent.onAppear)
            .navigationTitle("메모")
        }
    }

    @ViewBuilder
    func memoFABButton(action: @escaping () -> Void) -> some View {
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
    }

    @ViewBuilder
    func memoRowView(memo: MemoEntity) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(memo.content)
                    .lineLimit(nil)

                Text(memo.createdAt.custom("a hh시 mm분 ss초"))
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(4)
        .overlay {
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.black)
        }
    }
}
