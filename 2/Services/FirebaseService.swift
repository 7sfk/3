import Foundation

class FirebaseService {
    // Заглушка для Firebase сервиса
    static let shared = FirebaseService()
    
    private init() {}
    
    func configure() {
        print("Firebase configured")
    }
    
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        // Заглушка для входа
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion(true)
        }
    }
}
