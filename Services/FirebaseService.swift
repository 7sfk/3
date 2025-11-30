import Foundation

class FirebaseService {
    static let shared = FirebaseService()

    private var sampleProjects: [ProjectContainer] = [
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
    
    private var sampleUsers: [Employee] = [
        Employee(id: "admin1", name: "Константинов К.А.", role: .admin, email: "admin@example.com", phone: "123-001"),
        Employee(id: "foreman1", name: "Прорабов П.П.", role: .foreman, email: "foreman1@example.com", phone: "456-001"),
        Employee(id: "foreman2", name: "Началов Н.Н.", role: .foreman, email: "foreman2@example.com", phone: "456-002"),
        Employee(id: "worker1", name: "Иванов И.И.", role: .worker, email: "worker@example.com", phone: "789-001"),
        Employee(id: "worker2", name: "Петров П.П.", role: .worker, email: "worker2@example.com", phone: "789-002"),
        Employee(id: "worker3", name: "Сидоров С.С.", role: .worker, email: "worker3@example.com", phone: "789-003"),
        Employee(id: "supplier1", name: "Снабженцев С.С.", role: .supplier, email: "supplier1@example.com", phone: "987-001"),
        Employee(id: "inspector1", name: "Инспекторов И.И.", role: .inspector, email: "inspector1@example.com", phone: "654-001")
    ]
    
    private var sampleTasks: [ProjectTask] = [
        ProjectTask(id: "t1", name: "Установка окон", description: "Установить окна на 1-5 этажах", assignedTo: "worker1", projectId: "1", isCompleted: false, dueDate: Date().addingTimeInterval(86400 * 5)),
        ProjectTask(id: "t2", name: "Кладка кирпича", description: "Внешние стены, секция А", assignedTo: "worker1", projectId: "1", isCompleted: true, dueDate: Date().addingTimeInterval(86400 * 2)),
        ProjectTask(id: "t3", name: "Прокладка кабеля", description: "Электрические кабели, 2 этаж", assignedTo: "worker2", projectId: "1", isCompleted: false, dueDate: Date().addingTimeInterval(86400 * 3)),
        ProjectTask(id: "t4", name: "Внутренняя отделка", description: "Шпаклевка стен в холле", assignedTo: "worker2", projectId: "1", isCompleted: false, dueDate: Date().addingTimeInterval(86400 * 10)),
        ProjectTask(id: "t5", name: "Земляные работы", description: "Рытье котлована под фундамент", assignedTo: "worker3", projectId: "2", isCompleted: false, dueDate: Date().addingTimeInterval(86400 * 7)),
        ProjectTask(id: "t6", name: "Закупка арматуры", description: "Закупить 10 тонн арматуры класса А500", assignedTo: "supplier1", projectId: "2", isCompleted: false, dueDate: Date().addingTimeInterval(86400 * 4))
    ]

    private init() {}

    func login(email: String, password: String, completion: @escaping (Bool, UserRole?, String?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if let user = self.sampleUsers.first(where: { $0.email == email }) {
                completion(true, user.role, user.id)
            } else {
                completion(false, nil, nil)
            }
        }
    }
    
    func fetchProjects(forUser userId: String, role: UserRole, completion: @escaping ([ProjectContainer]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let projects: [ProjectContainer]
            switch role {
            case .admin:
                projects = self.sampleProjects
            case .foreman:
                projects = self.sampleProjects.filter { $0.foremanId == userId }
            case .worker, .supplier, .inspector:
                projects = self.sampleProjects.filter { $0.assignedUsers.contains(userId) }
            }
            completion(projects)
        }
    }
    
    func createProject(name: String, address: String, budget: Double, completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let newProject = ProjectContainer(
                id: UUID().uuidString,
                name: name,
                address: address,
                createdDate: Date(),
                createdBy: "admin1",
                assignedUsers: ["admin1"],
                foremanId: "",
                status: .planning,
                description: "Новый проект, созданный администратором.",
                budget: budget,
                timeline: ProjectTimeline(
                    startDate: Date(),
                    plannedEndDate: Calendar.current.date(byAdding: .month, value: 12, to: Date())!,
                    milestones: []
                ),
                permissions: ProjectPermissions(
                    canView: ["admin1"],
                    canEdit: ["admin1"],
                    canManageUsers: ["admin1"],
                    canViewFinancials: ["admin1"]
                )
            )
            self.sampleProjects.append(newProject)
            completion(true)
        }
    }
    
    func fetchTasks(for userId: String, projectId: String, completion: @escaping ([ProjectTask]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let tasks = self.sampleTasks.filter { $0.projectId == projectId && $0.assignedTo == userId }
            completion(tasks)
        }
    }
    
    func fetchAllTasks(for projectId: String, completion: @escaping ([ProjectTask]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            let tasks = self.sampleTasks.filter { $0.projectId == projectId }
            completion(tasks)
        }
    }
    
    func fetchTeam(for projectId: String, completion: @escaping ([Employee]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            guard let project = self.sampleProjects.first(where: { $0.id == projectId }) else {
                completion([])
                return
            }
            let team = self.sampleUsers.filter { project.assignedUsers.contains($0.id) }
            completion(team)
        }
    }
    
    func fetchEmployee(withId id: String, completion: @escaping (Employee?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let employee = self.sampleUsers.first(where: { $0.id == id })
            completion(employee)
        }
    }
}
