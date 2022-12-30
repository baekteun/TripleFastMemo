protocol MemoLockerStateProtocol {
    var boxedMemoList: [MemoEntity] { get }
}

protocol MemoLockerActionProtocol: AnyObject {
    func onAppear()
    func onDelete(id: String)
}
