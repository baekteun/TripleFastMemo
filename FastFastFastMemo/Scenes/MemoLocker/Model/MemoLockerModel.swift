import Foundation
import GRDB

final class MemoLockerModel: ObservableObject, MemoLockerStateProtocol {
    @Published var boxedMemoList: [MemoEntity] = []
    @Published var isPresentedToast: Bool = false
    @Published var toastMessage: String = ""
}

extension MemoLockerModel: MemoLockerActionProtocol {
    func onAppear() {
        let memoList = try? LocalDatabase.shared.readRecords(as: MemoEntity.self) { memo, db in
            try memo.filter(Column("memoType") == MemoType.boxing.rawValue)
                .order([Column("createdAt").desc])
                .fetchAll(db)
        }
        boxedMemoList = memoList ?? []
    }

    func onDelete(id: String) {
        boxedMemoList.removeAll { $0.id == id }
        try? LocalDatabase.shared.delete(record: MemoEntity.self, key: id)
    }

    func presentToToast(message: String) {
        isPresentedToast = true
        toastMessage = message
    }

    func dismissToToast() {
        isPresentedToast = false
    }
}
