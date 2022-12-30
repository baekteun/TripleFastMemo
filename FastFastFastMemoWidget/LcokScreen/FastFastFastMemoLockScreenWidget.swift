import WidgetKit
import SwiftUI
import GRDB

struct FastFastFastMemoLockScreenEntry: TimelineEntry {
    var date: Date
    var memos: [MemoEntity]
}

struct FastFastFastMemoLockScreenTimelineProvider: TimelineProvider {
    typealias Entry = FastFastFastMemoLockScreenEntry

    func placeholder(in context: Context) -> FastFastFastMemoLockScreenEntry {
        .init(date: Date(), memos: [])
    }

    func getSnapshot(
        in context: Context,
        completion: @escaping (FastFastFastMemoLockScreenEntry) -> Void
    ) {
        let memos = try? LocalDatabase.shared.readRecords(as: MemoEntity.self, ordered: [Column("createdAt").desc])
        let entry = FastFastFastMemoLockScreenEntry(date: Date(), memos: memos ?? [])
        completion(entry)
    }

    func getTimeline(
        in context: Context,
        completion: @escaping (Timeline<FastFastFastMemoLockScreenEntry>) -> Void
    ) {
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 1, to: Date()) ?? .init()
        let memos = try? LocalDatabase.shared.readRecords(as: MemoEntity.self, ordered: [Column("createdAt").desc])
        let entry = FastFastFastMemoLockScreenEntry(date: Date(), memos: memos ?? [])
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }
}

struct FastFastFastMemoLockScreenWidget: Widget {
    let kind = "FastFastFastLockScreen"

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: FastFastFastMemoLockScreenTimelineProvider()
        ) { entry in
            FastFastFastMemoWidgetEntryView(entry: entry)
                .widgetURL(URL(string: "fff-memo://write"))
        }
        .configurationDisplayName("매우매우매우 빠른 메모")
        .description("빠르게 작성 ㄱㄱ")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge, .accessoryCircular, .accessoryRectangular])
    }
}
