import Foundation

final class NewMemoModel: ObservableObject, NewMemoStateProtocol {
    let database = LocalDatabase.shared
    @Published var content: String = ""
    @Published var isSuccessSave: Bool = false
}

extension NewMemoModel: NewMemoActionProtocol {
    func contentChanged(content: String) {
        self.content = content
    }

    func saveButtonDidTap() {
        let memo = MemoEntity(
            id: UUID().uuidString,
            content: content,
            createdAt: Date()
        )
        do {
            try database.save(record: memo)
            isSuccessSave = true
        } catch {
            print(error)
        }
    }
}
