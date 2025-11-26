import Foundation

struct PurchaseOrder: Identifiable, Codable {
    var id: String
    var itemName: String
    var quantity: Int
    var supplier: String
    var orderDate: Date
    var status: OrderStatus
}

enum OrderStatus: String, Codable {
    case pending = "pending"
    case ordered = "ordered"
    case delivered = "delivered"
    case cancelled = "cancelled"
}
