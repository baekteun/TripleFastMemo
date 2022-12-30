import Combine

final class MemoLockerIntent: MemoLockerIntentProtocol {
    private weak var model: MemoLockerActionProtocol?

    init(
        model: any MemoLockerActionProtocol
    ) {
        self.model = model
    }

    func onAppear() {
        model?.onAppear()
    }

    func onDelete(id: String) {
        model?.onDelete(id: id)
    }
}
