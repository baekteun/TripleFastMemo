import SwiftUI

extension MemoLockerView {
    static func build() -> some View {
        let model = MemoLockerModel()
        let intent = MemoLockerIntent(model: model)
        let container = MVIContainer(
            intent: intent as any MemoLockerIntentProtocol,
            model: model as any MemoLockerStateProtocol,
            modelChangePublisher: model.objectWillChange
        )
        return MemoLockerView(container: container)
    }
}
