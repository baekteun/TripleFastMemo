
protocol MemoListStateProtocol {
    var memoList: [MemoEntity] { get }
}

protocol MemoListActionProtocol: AnyObject {
    func updateMemoList(memoList: [MemoEntity])
}
