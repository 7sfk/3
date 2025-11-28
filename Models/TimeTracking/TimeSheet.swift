import Foundation

enum TimeSheetStatus: String, Codable {
    case draft = "draft"
    case active = "active"
    case completed = "completed"
    case pending = "pending"
    case submitted = "submitted"
}

struct TimeSheet: Identifiable, Codable {
    var id = UUID()
    var employeeId: String
    var userId: String
    var projectId: String
    var checkIn: Date
    var checkOut: Date?
    var breakStart: Date?
    var breakEnd: Date?
    var totalHours: Double
    var status: TimeSheetStatus
    var tasks: [WorkTask]
    var notes: String?
    
    init(employeeId: String, userId: String, projectId: String, checkIn: Date = Date(), checkOut: Date? = nil, 
         breakStart: Date? = nil, breakEnd: Date? = nil, totalHours: Double = 0.0, status: TimeSheetStatus = .draft, 
         tasks: [WorkTask] = [], notes: String? = nil) {
        self.employeeId = employeeId
        self.userId = userId
        self.projectId = projectId
        self.checkIn = checkIn
        self.checkOut = checkOut
        self.breakStart = breakStart
        self.breakEnd = breakEnd
        self.totalHours = totalHours
        self.status = status
        self.tasks = tasks
        self.notes = notes
    }
}
