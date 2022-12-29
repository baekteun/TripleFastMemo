import Foundation

protocol MemoListIntentProtocol {
    func onAppear()
    func onDeleteMemo(id: String)
    func toggleNewMemo(toggle: Bool)
    func newTextChanged(new: String)
    func submitNewMemo(content: String)
}

