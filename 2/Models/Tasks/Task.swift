import Foundation

struct Task: Identifiable, Codable {
    var id: String
    var title: String
    var completed: Bool
    var assignedTo: String // Employee ID
}
