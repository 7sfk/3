import SwiftUI

struct AIRecommendation: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let priority: Priority
    let impact: Impact
    let icon: String
    let category: RecommendationCategory
}

enum Priority: String {
    case low = "Низкий"
    case medium = "Средний"
    case high = "Высокий"
    case critical = "Критический"
    
    var color: Color {
        switch self {
        case .low: return .green
        case .medium: return .yellow
        case .high: return .orange
        case .critical: return .red
        }
    }
}

enum Impact: String {
    case minor = "Низкое"
    case moderate = "Среднее"
    case significant = "Высокое"
    case critical = "Критическое"
}

enum RecommendationCategory: String, CaseIterable {
    case schedule = "График"
    case budget = "Бюджет"
    case resources = "Ресурсы"
    case quality = "Качество"
    case safety = "Безопасность"
    case design = "Дизайн"
}
