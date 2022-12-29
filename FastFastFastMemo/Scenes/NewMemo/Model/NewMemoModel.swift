import Foundation

final class NewMemoModel: ObservableObject, NewMemoStateProtocol {
    @Published var content: String = ""
}

extension NewMemoModel: NewMemoActionProtocol {
    func contentChanged(content: String) {
        self.content = content
    }
}
