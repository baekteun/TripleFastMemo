import GRDB
import Foundation

public struct LocalDatabase {
    static let shared = LocalDatabase { migrator in
#if DEBUG
        migrator.eraseDatabaseOnSchemaChange = true
#endif
        migrator.registerMigration("v1.0.0") { db in
            try db.create(table: "memoEntity") { t in
                t.column("id", .text).primaryKey(onConflict: .replace).notNull()
                t.column("content", .text)
                t.column("createdAt", .date)
                t.column("memoType", .text).defaults(to: "PUBLISH")
            }
        }
    }
    private let dbQueue: DatabaseQueue
    private var migrator = DatabaseMigrator()

    public func save(record: some FetchableRecord & PersistableRecord) throws {
        try dbQueue.write { db in
            try record.insert(db)
        }
    }

    public func save(records: [some FetchableRecord & PersistableRecord]) throws {
        try dbQueue.write { db in
            try records.forEach { record in
                try record.insert(db)
            }
        }
    }

    public func readRecords<Record: FetchableRecord & PersistableRecord>(
        as record: Record.Type,
        ordered: [SQLOrderingTerm] = []
    ) throws -> [Record] {
        try dbQueue.write { db in
            try record.order(ordered).fetchAll(db)
        }
    }

    public func readRecords<Record: FetchableRecord & PersistableRecord>(
        as record: Record.Type,
        query: (Record.Type) throws -> [Record]
    ) throws -> [Record] {
        try dbQueue.write { db in
            try query(record)
        }
    }

    public func readRecord<Record: FetchableRecord & PersistableRecord>(
        record: Record.Type,
        at key: some DatabaseValueConvertible
    ) throws -> Record? {
        try dbQueue.read { db in
            try record.fetchOne(db, key: key)
        }
    }

    public func readRecord<Record: FetchableRecord & PersistableRecord>(
        as record: Record.Type,
        query: (Record.Type) throws -> Record
    ) throws -> Record {
        try dbQueue.write { db in
            try query(record)
        }
    }

    public func updateRecord<Record: FetchableRecord & PersistableRecord>(
        record: Record.Type,
        at key: any DatabaseValueConvertible,
        transform: (inout Record) -> Void
    ) throws {
        try dbQueue.write { db in
            if var value = try record.fetchOne(db, key: key) {
                try value.updateChanges(db) {
                    transform(&$0)
                }
            }
        }
    }

    public func delete(
        record: some FetchableRecord & PersistableRecord
    ) throws {
        try dbQueue.write { db in
            _ = try record.delete(db)
        }
    }

    public func delete<Record: FetchableRecord & PersistableRecord>(
        record: Record.Type,
        key: some DatabaseValueConvertible
    ) throws {
        try dbQueue.write { db in
            _ = try record.deleteOne(db, key: key)
        }
    }

    public func deleteAll<Record: FetchableRecord & PersistableRecord>(
        record: Record.Type
    ) throws {
        try dbQueue.write { db in
            _ = try record.deleteAll(db)
        }
    }
}

public extension LocalDatabase {
    init(migrate: (inout DatabaseMigrator) -> Void) {
        var url = AppGroup.group.containerURL

        if #available(iOS 16, *) {
            url.append(path: "TodayWhat")
        } else {
            url.appendPathComponent("TodayWhat")
        }

        try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)

        if #available(iOS 16, *) {
            url.append(path: "TodayWhat.sqlite")
        } else {
            url.appendPathComponent("TodayWhat.sqlite")
        }
        var dir = ""

        if #available(iOS 16, *) {
            dir = url.path()
        } else {
            dir = url.path
        }

        if #available(iOS 16, *) {
            dir.replace("%20", with: " ")
        } else {
            dir = dir.replacingOccurrences(of: "%20", with: " ")
        }

        do {
            dbQueue = try DatabaseQueue(path: dir)
        } catch {
            fatalError()
        }
        migrate(&migrator)
        try? migrator.migrate(dbQueue)
    }
}
