import SwiftUI

extension View {
    func `if`<T: View>(
        _ condition: Bool,
        transform: (Self) -> T
    ) -> some View {
        Group {
            if condition { transform(self) } else { self }
        }
    }
}
