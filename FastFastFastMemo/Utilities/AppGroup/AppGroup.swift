import Foundation

public enum AppGroup: String {
    case group = "group.baegteun.FastFastFastMemo"

    public var containerURL: URL {
        switch self {
        case .group:
            return FileManager.default
                .containerURL(forSecurityApplicationGroupIdentifier: self.rawValue)!
        }
    }
}
