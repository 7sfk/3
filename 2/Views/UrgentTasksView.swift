import SwiftUI

struct UrgentTasksView: View {
    @ObservedObject var tasksVM: TasksViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(.red)
                Text("Срочные задачи")
                    .font(.headline)
                Spacer()
                Text("🔴")
                    .font(.title2)
            }
            
            let urgentTasks = tasksVM.tasks.filter { !$0.completed }.prefix(3)
            
            if urgentTasks.isEmpty {
                Text("Все задачи выполнены! 🎉")
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
            } else {
                ForEach(Array(urgentTasks)) { task in
                    UrgentTaskCard(task: task)
                }
            }
        }
        .padding()
        .background(Color.red.opacity(0.1))
        .cornerRadius(12)
    }
}

struct UrgentTaskCard: View {
    let task: Task
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                .foregroundColor(task.completed ? .green : .red)
                .font(.title3)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(task.title)
                    .font(.subheadline)
                    .bold()
                    .strikethrough(task.completed, color: .gray)
                
                HStack {
                    Text("Назначено: Сотрудник #\(task.assignedTo)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    if !task.completed {
                        Text("СРОЧНО")
                            .font(.caption2)
                            .foregroundColor(.white)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.red)
                            .cornerRadius(4)
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: .gray.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}
