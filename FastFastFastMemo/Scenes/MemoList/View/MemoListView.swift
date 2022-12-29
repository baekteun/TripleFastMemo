import SwiftUI

struct MemoListView: View {
    @StateObject var container: MVIContainer<MemoListIntentProtocol, MemoListStateProtocol>
    private var intent: any MemoListIntentProtocol { container.intent }
    private var state: any MemoListStateProtocol { container.model }
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    LazyVStack {
                        ForEach(state.memoList, id: \.id) { memo in
                            memoRowView(memo: memo)
                        }
                    }
                }

                VStack {
                    Spacer()

                    HStack {
                        Spacer()

                        NavigationLink {
                            DeferView {
                                NewMemoView.build()
                            }
                        } label: {
                            memoFABButton()
                        }
                    }
                }
            }
            .onAppear(perform: intent.onAppear)
            .navigationTitle("메모")
        }
    }

    @ViewBuilder
    func memoFABButton() -> some View {
        Image(systemName: "plus")
            .foregroundColor(.white)
            .frame(width: 64, height: 64)
            .background {
                Color.black
            }
            .clipShape(Circle())
            .padding(24)
    }

    @ViewBuilder
    func memoRowView(memo: MemoEntity) -> some View {
        HStack {
            Text(memo.content)
        }
    }
}
