import Foundation

struct MaterialUsage: Identifiable, Codable {
    var id = UUID()
    var name: String
    var quantity: Double
    var unit: String
}
