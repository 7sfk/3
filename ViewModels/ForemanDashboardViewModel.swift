import Foundation
import Combine

class ForemanDashboardViewModel: ObservableObject {
    @Published var project: ProjectContainer
    @Published var tasks: [ProjectTask] = []
    @Published var team: [Employee] = []
    @Published var isLoading: Bool = false

    init(project: ProjectContainer) {
        self.project = project
    }

    func fetchAllData() {
        isLoading = true
        // Здесь должна быть логика для загрузки данных
        // (задачи, команда и т.д.)
        // Для примера я просто выключу isLoading через 2 секунды
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isLoading = false
        }
    }
}
