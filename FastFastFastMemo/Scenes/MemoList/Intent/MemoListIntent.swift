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
        let memoList = try? database.readRecords(as: MemoEntity.self, query: { memo, db in
            try memo.filter(Column("memoType") == MemoType.publish.rawValue)
                .order([Column("createdAt").desc])
                .fetchAll(db)
        })

        model?.updateMemoList(memoList: memoList ?? [])
    }

    func onDeleteMemo(id: String) {
        try? database.delete(record: MemoEntity.self, key: id)
        model?.removeMemo(id: id)
    }

    func onBoxingMemo(id: String) {
        try? database.updateRecord(record: MemoEntity.self, at: id) { memo in
            memo = .init(id: memo.id, content: memo.content, createdAt: memo.createdAt, memoType: .boxing)
        }
        model?.onBoxingMemo(id: id)
    }

    func toggleNewMemo(toggle: Bool) {
        model?.toggleNewMemo(toggle: toggle)
    }

    func newTextChanged(new: String) {
        model?.newTextChanged(new: new)
    }

    func submitNewMemo(content: String) {
        guard !content.isEmpty else { return }
        let memo = MemoEntity(
            id: UUID().uuidString,
            content: content,
            createdAt: Date(),
            memoType: .publish
        )
        try? database.save(record: memo)
        guard let memoList = try? database.readRecords(as: MemoEntity.self, query: { memo, db in
            try memo.filter(Column("memoType") == MemoType.publish.rawValue)
                .order([Column("createdAt").desc])
                .fetchAll(db)
        }) else { return }
        let filteredMemoList = memoList.filter { $0.createdAt.compare(Date()) == .orderedSame }
        model?.updateMemoList(memoList: filteredMemoList)
        model?.submitNewMemo()
        model?.toggleNewMemo(toggle: false)
    }

    func presentToToast(message: String) {
        model?.presentToToast(message: message)
    }

    func dismissToToast() {
        model?.dismissToToast()
    }
}
