import SwiftUI
import WidgetKit

struct FastFastFastMemoWidgetEntryView: View {
    @Environment(\.widgetFamily) var widgetFamily
    let entry: FastFastFastMemoLockScreenTimelineProvider.Entry

    init(entry: FastFastFastMemoLockScreenTimelineProvider.Entry) {
        self.entry = entry
    }

    var body: some View {
        widgetBody()
    }

    @ViewBuilder
    func widgetBody() -> some View {
        switch widgetFamily {
        case .systemSmall:
            FFFMemoSmallWidgetView(entry: entry)

        case .systemMedium:
            FFFMemoMediumWidgetView(entry: entry)

        case .accessoryCircular:
            FFFMemoAccessoryCircularView()

        case .accessoryRectangular:
            FFFMemoAccessoryRectangular(entry: entry)
            
        default:
            EmptyView()
        }
    }
}

private struct FFFMemoSmallWidgetView: View {
    let entry: FastFastFastMemoLockScreenTimelineProvider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(Array(entry.memos.prefix(7)), id: \.id) { memo in
                HStack {
                    Text(memo.content)
                        .font(.callout)

                    Spacer()
                }
            }
        }
        .padding(12)
    }
}

private struct FFFMemoMediumWidgetView: View {
    let entry: FastFastFastMemoLockScreenTimelineProvider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(Array(entry.memos.prefix(7)), id: \.id) { memo in
                HStack {
                    Text(memo.content)
                        .font(.callout)

                    Spacer()

                    Text(memo.createdAt.custom("a hh시 mm분 ss초"))
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(12)
    }
}

private struct FFFMemoAccessoryCircularView: View {
    var body: some View {
        Image(systemName: "square.and.pencil.circle.fill")
            .resizable()
            .frame(width: 66, height: 66)
            .clipShape(Circle())
            .foregroundColor(.gray)
    }
}

private struct FFFMemoAccessoryRectangular: View {
    let entry: FastFastFastMemoLockScreenTimelineProvider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(Array(entry.memos.prefix(3)), id: \.id) { memo in
                HStack {
                    Text(memo.content)
                        .foregroundColor(.gray)

                    Spacer()
                }
            }
        }
        .padding(4)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.3))
        }
    }
}
