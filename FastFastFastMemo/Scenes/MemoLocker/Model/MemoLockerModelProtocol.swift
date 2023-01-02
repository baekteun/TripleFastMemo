protocol MemoLockerStateProtocol {
    var boxedMemoList: [MemoEntity] { get }
    var isPresentedToast: Bool { get }
    var toastMessage: String { get }
}

protocol MemoLockerActionProtocol: AnyObject {
    func onAppear()
    func onDelete(id: String)
    func presentToToast(message: String)
    func dismissToToast()
}
