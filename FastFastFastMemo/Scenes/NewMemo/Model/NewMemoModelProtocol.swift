protocol NewMemoStateProtocol {
    var content: String { get }
}

protocol NewMemoActionProtocol: AnyObject {
    func contentChanged(content: String)
}
