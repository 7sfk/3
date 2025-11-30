import Foundation

class Notifications {
    
    static func sendAlert(to user: String, message: String) {
        // TODO: интегрировать с push-уведомлениями или email
        print("Уведомление для \(user): \(message)")
    }
    
}
