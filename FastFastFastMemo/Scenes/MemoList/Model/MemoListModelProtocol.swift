protocol MemoListStateProtocol {
    var memoList: [MemoEntity] { get }
    var isOnNewMemo: Bool { get }
    var newText: String { get }
}

protocol MemoListActionProtocol: AnyObject {
    func toggleNewMemo(toggle: Bool)
    func updateMemoList(memoList: [MemoEntity])
    func removeMemo(id: String)
    func onBoxingMemo(id: String)
    func newTextChanged(new: String)
    func submitNewMemo()
}
