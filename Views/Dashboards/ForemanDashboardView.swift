import SwiftUI


// MARK: - Main View
struct ForemanDashboardView: View {
    @StateObject private var viewModel: ForemanDashboardViewModel
    
    init(project: ProjectContainer) {
        _viewModel = StateObject(wrappedValue: ForemanDashboardViewModel(project: project))
    }
    
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView("Загрузка данных...")
            } else {
                VStack(alignment: .leading, spacing: 20) {
                    ProjectSummaryView(project: viewModel.project, tasks: viewModel.tasks)
                    ProjectTeamView(team: viewModel.team)
                    ProjectTasksView(tasks: viewModel.tasks)
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.fetchAllData()
        }
    }
}

// MARK: - Summary View
struct ProjectSummaryView: View {
    let project: ProjectContainer
    let tasks: [ProjectTask]
    
    private var completionPercentage: Double {
        let completedTasks = tasks.filter { $0.isCompleted }.count
        return tasks.isEmpty ? 0 : Double(completedTasks) / Double(tasks.count)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Обзор проекта")
                .font(.title2)
                .bold()
            
            HStack {
                StatCard(title: "Бюджет", value: formatBudget(project.budget), color: .blue)
                StatCard(title: "Срок сдачи", value: formatDate(project.timeline.plannedEndDate), color: .orange)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Прогресс выполнения: \(Int(completionPercentage * 100))%")
                ProgressView(value: completionPercentage)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

// MARK: - Team View
struct ProjectTeamView: View {
    let team: [Employee]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Команда проекта")
                .font(.title2)
                .bold()
            
            ForEach(team) { member in
                HStack {
                    Image(systemName: "person.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                    VStack(alignment: .leading) {
                        Text(member.name)
                            .font(.headline)
                        Text(member.role.displayName)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

// MARK: - Tasks View
struct ProjectTasksView: View {
    let tasks: [ProjectTask]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Все задачи")
                .font(.title2)
                .bold()
            
            ForEach(tasks) { task in
                TaskRow(task: task)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

// MARK: - Helper Views
struct StatCard: View {
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(value)
                .font(.headline)
                .bold()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(10)
    }
}

struct TaskRow: View {
    let task: ProjectTask
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(task.name)
                    .font(.headline)
                Text("Исполнитель: \(task.assignedTo)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            if task.isCompleted {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            } else {
                Image(systemName: "timer")
                    .foregroundColor(.orange)
            }
        }
    }
}

// MARK: - Formatting Helpers
private func formatBudget(_ budget: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencySymbol = "₽"
    formatter.maximumFractionDigits = 0
    return formatter.string(from: NSNumber(value: budget)) ?? "\(budget)₽"
}

private func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yy"
    return formatter.string(from: date)
}
