import Foundation

final class MemoListModel: ObservableObject, MemoListStateProtocol {
    @Published var memoList: [MemoEntity] = []
    @Published var isOnNewMemo: Bool = false
    @Published var newText: String = ""
}

extension MemoListModel: MemoListActionProtocol {
    func toggleNewMemo(toggle: Bool) {
        isOnNewMemo = toggle
    }

    func updateMemoList(memoList: [MemoEntity]) {
        self.memoList = memoList
    }

    func removeMemo(id: String) {
        self.memoList.removeAll { $0.id == id }
    }

    func onBoxingMemo(id: String) {
        self.memoList.removeAll { $0.id == id }
    }

    func newTextChanged(new: String) {
        newText = new
    }

    func submitNewMemo() {
        newText = ""
    }
}
