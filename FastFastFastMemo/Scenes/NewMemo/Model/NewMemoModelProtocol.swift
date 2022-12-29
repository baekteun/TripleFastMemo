protocol NewMemoStateProtocol {
    var content: String { get }
    var isSuccessSave: Bool { get }
}

protocol NewMemoActionProtocol: AnyObject {
    func contentChanged(content: String)
    func saveButtonDidTap()
}
