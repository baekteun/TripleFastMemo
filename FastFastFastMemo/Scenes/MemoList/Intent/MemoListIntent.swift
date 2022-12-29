import Foundation
import GRDB

final class MemoListIntent: MemoListIntentProtocol {
    private let database = LocalDatabase.shared
    private weak var model: MemoListActionProtocol?

    init(
        model: MemoListActionProtocol
    ) {
        self.model = model
    }

    func onAppear() {
        guard let memoList = try? database.readRecords(
            as: MemoEntity.self,
            ordered: [Column("createdAt").desc]
        ) else { return }
        model?.updateMemoList(memoList: memoList)
    }

    func onDeleteMemo(id: String) {
        try? database.delete(record: MemoEntity.self, key: id)
        model?.removeMemo(id: id)
    }

    func toggleNewMemo(toggle: Bool) {
        model?.toggleNewMemo(toggle: toggle)
    }

    func newTextChanged(new: String) {
        model?.newTextChanged(new: new)
    }

    func submitNewMemo(content: String) {
        let memo = MemoEntity(
            id: UUID().uuidString,
            content: content,
            createdAt: Date()
        )
        try? database.save(record: memo)
        guard let memoList = try? database.readRecords(
            as: MemoEntity.self,
            ordered: [Column("createdAt").desc]
        ) else { return }
        model?.updateMemoList(memoList: memoList)
        model?.submitNewMemo()
        model?.toggleNewMemo(toggle: false)
    }
}
