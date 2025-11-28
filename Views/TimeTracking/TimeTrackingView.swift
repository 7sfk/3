import SwiftUI
import Combine

struct TimeTrackingView: View {
    @StateObject private var timeService = TimeTrackingService()
    @State private var newTaskName = ""
    @State private var selectedProject = "Текущий проект"
    @State private var showAddTask = false
    
    let projects = ["Проект 1", "Проект 2", "Проект 3", "Текущий проект"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Статус текущей смены
                statusCard
                
                // Управление сменой
                shiftControls
                
                // Список задач
                tasksList
                
                // Кнопка добавления задачи
                addTaskButton
                
                Spacer()
                
                // Статистика
                statisticsView
            }
            .padding()
            .navigationTitle("⏱ Учет времени")
            .sheet(isPresented: $showAddTask) {
                addTaskView
            }
            .onAppear {
                // Загружаем тестовые данные при первом запуске
                if timeService.timeSheets.isEmpty {
                    timeService.loadSampleData()
                }
            }
        }
    }
    
    private var statusCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "clock.fill")
                    .foregroundColor(.blue)
                Text("Текущая смена")
                    .font(.headline)
                Spacer()
                Text(timeService.currentSession != nil ? "АКТИВНА" : "НЕ АКТИВНА")
                    .font(.caption)
                    .padding(6)
                    .background(timeService.currentSession != nil ? Color.green : Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(4)
            }
            
            if let session = timeService.currentSession {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Начало: \(session.checkIn, style: .time)")
                    Text("Проект: \(session.projectId)")
                    Text("Статус: \(session.status.rawValue)")
                    
                    if let checkOut = session.checkOut {
                        Text("Завершена: \(checkOut, style: .time)")
                    }
                }
                .font(.subheadline)
            } else {
                Text("Смена не начата")
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
    
    private var shiftControls: some View {
        HStack(spacing: 15) {
            if timeService.currentSession == nil {
                Button(action: {
                    timeService.startWorkDay(
                        employeeId: "user_123",
                        userId: "current_user",
                        projectId: selectedProject
                    )
                }) {
                    HStack {
                        Image(systemName: "play.fill")
                        Text("Начать смену")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            } else {
                Button(action: {
                    timeService.takeBreak()
                }) {
                    HStack {
                        Image(systemName: "pause.fill")
                        Text("Перерыв")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
                Button(action: {
                    timeService.endWorkDay()
                }) {
                    HStack {
                        Image(systemName: "stop.fill")
                        Text("Завершить")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
        }
    }
    
    private var tasksList: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Задачи")
                    .font(.headline)
                Spacer()
                Text("\(currentTasksCount)")
                    .padding(6)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }
            
            if let session = timeService.currentSession, !session.tasks.isEmpty {
                ForEach(session.tasks) { task in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(task.name)
                                .fontWeight(.medium)
                            if let description = task.description {
                                Text(description)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        Spacer()
                        
                        Text(task.status.rawValue)
                            .font(.caption)
                            .padding(6)
                            .background(statusColor(for: task.status))
                            .foregroundColor(.white)
                            .cornerRadius(4)
                    }
                    .padding(.vertical, 4)
                }
            } else {
                Text("Нет задач")
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
            }
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }
    
    private var addTaskButton: some View {
        Button(action: {
            showAddTask = true
        }) {
            HStack {
                Image(systemName: "plus.circle.fill")
                Text("Добавить задачу")
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
    
    private var addTaskView: some View {
        NavigationView {
            Form {
                Section(header: Text("Новая задача")) {
                    TextField("Название задачи", text: $newTaskName)
                    
                    Picker("Проект", selection: $selectedProject) {
                        ForEach(projects, id: \.self) { project in
                            Text(project).tag(project)
                        }
                    }
                }
                
                Section {
                    Button("Добавить задачу") {
                        let newTask = WorkTask(
                            name: newTaskName,
                            description: "Задача для проекта \(selectedProject)",
                            status: .pending,
                            materials: []
                        )
                        timeService.addTask(newTask)
                        newTaskName = ""
                        showAddTask = false
                    }
                    .disabled(newTaskName.isEmpty)
                }
            }
            .navigationTitle("Новая задача")
            .navigationBarItems(trailing: Button("Отмена") {
                showAddTask = false
            })
        }
    }
    
    private var statisticsView: some View {
        HStack(spacing: 20) {
            VStack {
                Text("\(totalHoursToday, specifier: "%.1f")")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                Text("часов сегодня")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            VStack {
                Text("\(currentTasksCount)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                Text("задач")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            VStack {
                Text("\(completedTasksCount)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                Text("выполнено")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }
    
    private var currentTasksCount: Int {
        timeService.currentSession?.tasks.count ?? 0
    }
    
    private var completedTasksCount: Int {
        timeService.currentSession?.tasks.filter { $0.status == .completed }.count ?? 0
    }
    
    private var totalHoursToday: Double {
        timeService.timeSheets
            .filter { Calendar.current.isDateInToday($0.checkIn) }
            .reduce(0.0) { $0 + ($1.totalHours ) }
    }
    
    private func statusColor(for status: TaskStatus) -> Color {
        switch status {
        case .pending: return .orange
        case .inProgress: return .blue
        case .finishing: return .purple
        case .completed: return .green
        }
    }
}

#Preview {
    TimeTrackingView()
}
