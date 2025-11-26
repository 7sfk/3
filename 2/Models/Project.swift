import Foundation

struct Project: Identifiable, Codable {
    let id: String
    var name: String
    var description: String
    var startDate: Date
    var endDate: Date
    var budget: Double
    var status: ProjectStatus  // Используем ProjectStatus из ProjectContainer.swift
}
