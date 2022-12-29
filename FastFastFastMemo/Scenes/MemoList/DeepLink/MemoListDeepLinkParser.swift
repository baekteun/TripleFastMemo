import Foundation

struct MemoListDeepLinkParser: DeepLinkParser {
    var action: () -> Void

    func canHandleDeepLink(_ urlComponents: URLComponents) -> Bool {
        guard let host = urlComponents.host, host == "write" else { return false }
        guard urlComponents.scheme == "fff-memo" else { return false }
        return true
    }

    func handleDeepLink(_ urlComponents: URLComponents) {
        action()
    }
}
