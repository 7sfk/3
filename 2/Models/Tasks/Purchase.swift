import Foundation

struct Purchase: Identifiable, Codable {
    var id: String
    var item: String
    var quantity: Int
    var assignedTo: String // Employee ID
}
