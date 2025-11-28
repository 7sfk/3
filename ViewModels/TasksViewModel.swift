import Foundation
import Combine

class TasksViewModel: ObservableObject {
    @Published var tasks: [ProjectTask] = []
    @Published var urgentTasks: [ProjectTask] = []

    func fetchTasks() {
        // Логика для получения задач
    }
    
    func fetchUrgentTasks() {
        // Логика для получения срочных задач
    }

    func addTask(_ task: ProjectTask) {
        tasks.append(task)
    }

    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}
