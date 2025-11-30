import Foundation

struct ProjectMetrics {
    let completionPercentage: Int
    let budgetUtilization: Int
    let timelineAdherence: Int
    let qualityScore: Int
}

struct ProjectRisk: Identifiable {
    let id: String
    let title: String
    let description: String
    let probability: Double
    let impact: RiskImpact
    let category: RiskCategory
}

enum RiskImpact {
    case low, medium, high, critical
}

enum RiskCategory {
    case schedule, budget, resources, quality, safety, design
}
