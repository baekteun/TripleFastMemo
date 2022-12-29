import Foundation
import GRDB

struct MemoEntity: Equatable, Codable {
    let id: String
    let content: String
    let createdAt: Date
    let memoType: MemoType
}

extension MemoEntity: FetchableRecord, PersistableRecord {}
