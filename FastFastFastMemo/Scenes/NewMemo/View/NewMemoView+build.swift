import SwiftUI

extension NewMemoView {
    static func build() -> some View {
        let model = NewMemoModel()
        let intent = NewMemoIntent(model: model)
        let container = MVIContainer(
            intent: intent as NewMemoIntentProtocol,
            model: model as NewMemoStateProtocol,
            modelChangePublisher: model.objectWillChange
        )
        return NewMemoView(container: container)
    }
}
