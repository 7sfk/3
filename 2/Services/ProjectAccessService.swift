import SwiftUI
import Combine

class ProjectAccessService: ObservableObject {
    @Published var availableProjects: [ProjectContainer] = []
    
    func loadSampleData(for role: UserRole, user: String) {
        // Очищаем предыдущие проекты
        availableProjects = []
        
        // Все возможные проекты
        let allProjects = [
            ProjectContainer(
                id: "1", 
                name: "ЖК Комфорт",
                address: "ул. Строителей, 15",
                createdDate: Date(),
                createdBy: "admin1",
                assignedUsers: ["admin1", "foreman1", "worker1", "worker2", "supplier1", "inspector1"],
                foremanId: "foreman1",
                status: .inProgress,
                description: "Многоэтажный жилой комплекс с подземной парковкой",
                budget: 50000000,
                timeline: ProjectTimeline(
                    startDate: Date(),
                    plannedEndDate: Calendar.current.date(byAdding: .month, value: 6, to: Date())!,
                    milestones: []
                ),
                permissions: ProjectPermissions(
                    canView: ["admin1", "foreman1", "worker1", "worker2", "supplier1", "inspector1"],
                    canEdit: ["admin1", "foreman1"],
                    canManageUsers: ["admin1", "foreman1"],
                    canViewFinancials: ["admin1"]
                )
            ),
            ProjectContainer(
                id: "2",
                name: "Офисный центр",
                address: "пр. Мира, 28", 
                createdDate: Date(),
                createdBy: "admin1",
                assignedUsers: ["admin1", "foreman2", "worker3", "supplier1"],
                foremanId: "foreman2",
                status: .planning,
                description: "Бизнес-центр класса А с отделкой премиум-класса",
                budget: 75000000,
                timeline: ProjectTimeline(
                    startDate: Calendar.current.date(byAdding: .day, value: 30, to: Date())!,
                    plannedEndDate: Calendar.current.date(byAdding: .month, value: 8, to: Date())!,
                    milestones: []
                ),
                permissions: ProjectPermissions(
                    canView: ["admin1", "foreman2", "worker3", "supplier1"],
                    canEdit: ["admin1", "foreman2"],
                    canManageUsers: ["admin1"],
                    canViewFinancials: ["admin1"]
                )
            )
        ]
        
        // Фильтруем проекты по роли
        switch role {
        case .admin:
            availableProjects = allProjects
        case .foreman:
            availableProjects = allProjects.filter { $0.foremanId == "foreman1" }
        case .worker:
            availableProjects = allProjects.filter { $0.assignedUsers.contains("worker1") }
        case .supplier:
            availableProjects = allProjects.filter { $0.assignedUsers.contains("supplier1") }
        case .inspector:
            availableProjects = allProjects.filter { $0.assignedUsers.contains("inspector1") }
        }
        
        print("Загружено проектов для роли \(role.displayName): \(availableProjects.count)")
    }
    
    func selectProject(_ project: Project) {
        // Сохраняем выбранный проект
        print("Выбран проект: \(project.name)")
    }
}
