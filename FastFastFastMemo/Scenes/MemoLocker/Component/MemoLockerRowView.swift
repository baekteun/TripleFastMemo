import SwiftUI

struct MemoLockerRowView: View {
    let memo: MemoEntity

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(memo.content)
                    .lineLimit(nil)

                Text(memo.createdAt.custom("yyyy년 MM월 dd일 a hh시 mm분 ss초"))
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(4)
        .overlay {
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color("MainBlack"))
        }
    }
}
