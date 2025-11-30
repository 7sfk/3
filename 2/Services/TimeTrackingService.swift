import Foundation
import Combine

class TimeTrackingService: ObservableObject {
    @Published var currentTimeSheet: TimeSheet?
    @Published var timeSheets: [TimeSheet] = []
    
    var currentSession: TimeSheet? {
        return currentTimeSheet
    }
    
    func startWorkDay(employeeId: String, userId: String, projectId: String) {
        let newTimeSheet = TimeSheet(
            employeeId: employeeId,
            userId: userId,
            projectId: projectId,
            checkIn: Date(),
            status: .active
        )
        currentTimeSheet = newTimeSheet
        timeSheets.append(newTimeSheet)
    }
    
    func addTask(_ task: WorkTask) {
        guard var current = currentTimeSheet else { return }
        current.tasks.append(task)
        currentTimeSheet = current
        objectWillChange.send()
    }
    
    func takeBreak() {
        guard var current = currentTimeSheet else { return }
        current.breakStart = Date()
        currentTimeSheet = current
        objectWillChange.send()
    }
    
    func endBreak() {
        guard var current = currentTimeSheet else { return }
        current.breakEnd = Date()
        currentTimeSheet = current
        objectWillChange.send()
    }
    
    func endWorkDay() {
        guard var current = currentTimeSheet else { return }
        current.checkOut = Date()
        current.status = .completed
        current.totalHours = calculateTotalHours(timeSheet: current)
        currentTimeSheet = current
        objectWillChange.send()
    }
    
    func submitTimeSheet() {
        guard var current = currentTimeSheet else { return }
        current.status = .submitted
        currentTimeSheet = current
        objectWillChange.send()
    }
    
    func loadSampleData() {
        let sampleTasks = [
            WorkTask(name: "Планирование проекта", description: "Создание плана работ", status: .completed, materials: []),
            WorkTask(name: "Закупка материалов", description: "Заказ необходимых материалов", status: .inProgress, materials: []),
            WorkTask(name: "Монтаж конструкций", description: "Установка основных конструкций", status: .pending, materials: [])
        ]
        
        let sampleTimeSheet = TimeSheet(
            employeeId: "demo_employee",
            userId: "demo_user",
            projectId: "Демо проект",
            checkIn: Date().addingTimeInterval(-3600 * 4), // 4 часа назад
            status: .active,
            tasks: sampleTasks,
            notes: "Демонстрационная смена"
        )
        
        timeSheets = [sampleTimeSheet]
        currentTimeSheet = sampleTimeSheet
        objectWillChange.send()
    }
    
    private func calculateTotalHours(timeSheet: TimeSheet) -> Double {
        guard let checkOut = timeSheet.checkOut else { return 0.0 }
        
        let timeInterval = checkOut.timeIntervalSince(timeSheet.checkIn)
        let breakTime: Double
        
        if let breakStart = timeSheet.breakStart, let breakEnd = timeSheet.breakEnd {
            breakTime = breakEnd.timeIntervalSince(breakStart)
        } else {
            breakTime = 0.0
        }
        
        let totalSeconds = timeInterval - breakTime
        return totalSeconds / 3600.0
    }
}
