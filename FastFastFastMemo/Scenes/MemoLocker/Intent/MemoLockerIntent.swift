import Combine

final class MemoLockerIntent: MemoLockerIntentProtocol {
    private weak var model: MemoLockerActionProtocol?

    init(
        model: any MemoLockerActionProtocol
    ) {
        self.model = model
    }
}
