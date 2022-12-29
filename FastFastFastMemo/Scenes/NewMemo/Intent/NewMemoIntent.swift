import Foundation

final class NewMemoIntent: NewMemoIntentProtocol {
    private let database = LocalDatabase.shared
    private weak var model: NewMemoActionProtocol?

    init(
        model: NewMemoActionProtocol
    ) {
        self.model = model
    }

    func contentChanged(content: String) {
        model?.contentChanged(content: content)
    }
}
