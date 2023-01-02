import Foundation

protocol MemoLockerIntentProtocol {
    func onAppear()
    func onDelete(id: String)
    func presentToToast(message: String)
    func dismissToToast()
}
