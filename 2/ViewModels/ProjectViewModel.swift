import SwiftUI
import Combine

@MainActor
final class ProjectViewModel: ObservableObject {
    @Published var project: Project
    @Published var recommendations: [AIRecommendation] = []
    @Published var risks: [ProjectRisk] = []
    @Published var metrics: ProjectMetrics
    
    init() {
        self.project = Project(
            name: "ЖК Комфорт",
            description: "Многоэтажный жилой комплекс",
            status: .active, // Изменили с .inProgress на .active
            progress: 35
        )
        self.metrics = ProjectMetrics(
            completionPercentage: 35,
            budgetUtilization: 42,
            timelineAdherence: 78,
            qualityScore: 85
        )
        
        // Загружаем начальные рекомендации
        loadInitialRecommendations()
    }
    
    func analyzeRisks() {
        // Имитация AI-анализа
        let newRisks = [
            ProjectRisk(
                id: "1",
                title: "Отставание по графике",
                description: "Критический путь показывает задержку 5 дней",
                probability: 0.7,
                impact: .high,
                category: .schedule
            ),
            ProjectRisk(
                id: "2", 
                title: "Перерасход бюджета",
                description: "Текущие затраты превышают план на 12%",
                probability: 0.6,
                impact: .high,
                category: .budget
            )
        ]
        risks = newRisks
        
        generateRecommendations()
    }
    
    private func loadInitialRecommendations() {
        recommendations = [
            AIRecommendation(
                title: "Оптимизация расписания",
                description: "Критический путь показывает задержку 5 дней. Рекомендуется перераспределить ресурсы.",
                priority: .high,
                impact: .significant,
                icon: "calendar.badge.clock",
                category: .schedule
            ),
            AIRecommendation(
                title: "Балансировка ресурсов",
                description: "2 сотрудника перегружены, 3 - недогружены. Оптимизируйте распределение задач.",
                priority: .medium,
                impact: .moderate,
                icon: "person.2.circle",
                category: .resources
            ),
            AIRecommendation(
                title: "Контроль качества",
                description: "Последняя проверка выявила отклонения в 8% от стандартов. Усильте контроль.",
                priority: .medium,
                impact: .significant,
                icon: "checkmark.circle",
                category: .quality
            )
        ]
    }
    
    private func generateRecommendations() {
        // Добавляем рекомендации на основе рисков
        for risk in risks {
            let impact: Impact
            switch risk.impact {
            case .low: impact = .minor
            case .medium: impact = .moderate
            case .high: impact = .significant
            case .critical: impact = .critical
            }
            
            let recommendation = AIRecommendation(
                title: "Митгирование: \(risk.title)",
                description: risk.description,
                priority: risk.probability > 0.6 ? .high : .medium,
                impact: impact,
                icon: "shield",
                category: risk.category.toRecommendationCategory()
            )
            recommendations.insert(recommendation, at: 0)
        }
        
        // Ограничиваем количество рекомендаций
        recommendations = Array(recommendations.prefix(5))
    }
}

extension RiskCategory {
    func toRecommendationCategory() -> RecommendationCategory {
        switch self {
        case .schedule: return .schedule
        case .budget: return .budget
        case .resources: return .resources
        case .quality: return .quality
        case .safety: return .safety
        case .design: return .design
        }
    }
}
