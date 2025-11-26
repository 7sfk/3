import Foundation
import Combine

final class AppState: ObservableObject {
    @Published var currentUser: UserSession? = nil
}
