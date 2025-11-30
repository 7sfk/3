import Foundation

struct InventoryTransaction: Identifiable, Codable {
    let id: String
    let itemId: String
    let type: TransactionType
    let quantity: Double
    let date: Date
    let projectId: String
    let userId: String
    let userName: String
    let notes: String?
    let photoURLs: [String]
    let videoURLs: [String]
    let location: String? // Геолокация где была операция
    let signature: String? // Электронная подпись
}

enum TransactionType: String, Codable {
    case incoming = "incoming"   // Поступление на склад
    case outgoing = "outgoing"   // Выдача со склада
    case transfer = "transfer"   // Перемещение между объектами
    case adjustment = "adjustment" // Корректировка
    case writeOff = "write_off"  // Списание
    
    var displayName: String {
        switch self {
        case .incoming: return "Поступление"
        case .outgoing: return "Выдача"
        case .transfer: return "Перемещение"
        case .adjustment: return "Корректировка"
        case .writeOff: return "Списание"
        }
    }
    
    var icon: String {
        switch self {
        case .incoming: return "arrow.down.circle"
        case .outgoing: return "arrow.up.circle"
        case .transfer: return "arrow.left.arrow.right"
        case .adjustment: return "slider.horizontal.3"
        case .writeOff: return "xmark.circle"
        }
    }
    
    var color: String {
        switch self {
        case .incoming: return "green"
        case .outgoing: return "blue"
        case .transfer: return "orange"
        case .adjustment: return "yellow"
        case .writeOff: return "red"
        }
    }
}
