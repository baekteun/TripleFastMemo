import SwiftUI

extension MemoListView {
    static func build() -> some View {
        let model = MemoListModel()
        let intent = MemoListIntent(model: model)
        let container = MVIContainer(
            intent: intent as MemoListIntentProtocol,
            model: model as MemoListStateProtocol,
            modelChangePublisher: model.objectWillChange
        )
        return MemoListView(container: container)
    }
}
