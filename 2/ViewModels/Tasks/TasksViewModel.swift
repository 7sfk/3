import SwiftUI
import Combine

final class TasksViewModel: ObservableObject {
    @Published var tasks: [ProjectTask] = [
        ProjectTask(id: "1", name: "Подготовить площадку", description: "", assignedTo: "1", projectId: "1", isCompleted: false, dueDate: Date()),
        ProjectTask(id: "2", name: "Закупить материалы", description: "", assignedTo: "2", projectId: "1", isCompleted: true, dueDate: Date()),
        ProjectTask(id: "3", name: "Составить отчет", description: "", assignedTo: "3", projectId: "1", isCompleted: false, dueDate: Date())
    ]
}
