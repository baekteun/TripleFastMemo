import Foundation

final class MemoListModel: ObservableObject, MemoListStateProtocol {
    @Published var memoList: [MemoEntity] = []

    
}

extension MemoListModel: MemoListActionProtocol {
    func updateMemoList(memoList: [MemoEntity]) {
        self.memoList = memoList
    }
}
