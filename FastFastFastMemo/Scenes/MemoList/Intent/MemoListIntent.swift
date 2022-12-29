import Foundation

final class MemoListIntent: MemoListIntentProtocol {
    private let database = LocalDatabase.shared
    private weak var model: MemoListActionProtocol?

    init(
        model: MemoListActionProtocol
    ) {
        self.model = model
    }

    func onAppear() {
        guard let memoList = try? database.readRecords(as: MemoEntity.self) else { return }
        model?.updateMemoList(memoList: memoList)
    }
}
