import SwiftUI
import Combine

class ProjectAccessService: ObservableObject {
    @Published var availableProjects: [ProjectContainer] = []
    @Published var currentUser: String?
    @Published var currentUserRole: UserRole = .worker
    
    func loadSampleData() {
        // Общие тестовые проекты
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
            ),
            ProjectContainer(
                id: "3",
                name: "Школа №15",
                address: "ул. Образования, 5",
                createdDate: Calendar.current.date(byAdding: .day, value: -10, to: Date())!,
                createdBy: "admin1",
                assignedUsers: ["admin1", "foreman1", "worker4", "inspector1"],
                foremanId: "foreman1",
                status: .completed,
                description: "Реконструкция здания школы с современными классами",
                budget: 30000000,
                timeline: ProjectTimeline(
                    startDate: Calendar.current.date(byAdding: .month, value: -6, to: Date())!,
                    plannedEndDate: Calendar.current.date(byAdding: .day, value: -5, to: Date())!,
                    actualEndDate: Calendar.current.date(byAdding: .day, value: -5, to: Date())!,
                    milestones: []
                ),
                permissions: ProjectPermissions(
                    canView: ["admin1", "foreman1", "worker4", "inspector1"],
                    canEdit: ["admin1", "foreman1"],
                    canManageUsers: ["admin1"],
                    canViewFinancials: ["admin1"]
                )
            )
        ]
        
        // Устанавливаем проекты в зависимости от роли
        switch currentUserRole {
        case .admin:
            currentUser = "admin1"
            availableProjects = allProjects
            
        case .foreman:
            currentUser = "foreman1"
            availableProjects = allProjects.filter { $0.foremanId == "foreman1" }
            
        case .worker:
            currentUser = "worker1"
            availableProjects = allProjects.filter { $0.assignedUsers.contains("worker1") }
            
        case .supplier:
            currentUser = "supplier1"
            availableProjects = allProjects.filter { $0.assignedUsers.contains("supplier1") }
            
        case .inspector:
            currentUser = "inspector1"
            availableProjects = allProjects.filter { $0.assignedUsers.contains("inspector1") }
        }
    }
    
    // Проверка доступа пользователя к проекту
    func canAccessProject(_ projectId: String) -> Bool {
        guard let user = currentUser else { return false }
        
        // Админ видит все
        if currentUserRole == .admin { return true }
        
        // Проверяем назначенные проекты
        if let project = availableProjects.first(where: { $0.id == projectId }) {
            return project.assignedUsers.contains(user)
        }
        
        return false
    }
    
    // Получить проекты доступные текущему пользователю
    func getUserProjects() -> [ProjectContainer] {
        return availableProjects
    }
}
