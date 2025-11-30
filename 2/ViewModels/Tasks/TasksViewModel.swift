import SwiftUI
import Combine

final class TasksViewModel: ObservableObject {
    @Published var tasks: [Task] = [
        Task(id: "1", title: "Подготовить площадку", completed: false, assignedTo: "1"),
        Task(id: "2", title: "Закупить материалы", completed: true, assignedTo: "2"),
        Task(id: "3", title: "Составить отчет", completed: false, assignedTo: "3")
    ]
}
