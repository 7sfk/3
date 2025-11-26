import Foundation
import Combine

struct TaskItem: Identifiable {
    let id = UUID()
    let title: String
    let isDone: Bool
}

final class TasksViewModel: ObservableObject {
    @Published var tasks: [TaskItem] = [
        TaskItem(title: "Проверить материалы", isDone: false),
        TaskItem(title: "Согласовать чертежи", isDone: true)
    ]

    func toggleTask(_ task: TaskItem) {
        if let idx = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[idx] = TaskItem(title: task.title, isDone: !task.isDone)
        }
    }
}
