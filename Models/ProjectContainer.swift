import Foundation

struct ProjectContainer: Identifiable, Codable {
    var id: String
    var name: String
    var budget: Double
    var timeline: DateInterval
}
