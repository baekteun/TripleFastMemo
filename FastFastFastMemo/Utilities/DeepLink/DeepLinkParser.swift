import Foundation

protocol DeepLinkParser {
    func canHandleDeepLink(_ urlComponents: URLComponents) -> Bool
    func handleDeepLink(_ urlComponents: URLComponents)
}
