import Foundation

struct Project: Identifiable, Codable {
    let id: UUID
    var name: String
    var status: String
    var startDate: Date
    var endDate: Date?
}

