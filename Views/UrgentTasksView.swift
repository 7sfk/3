import SwiftUI

// This view displays a list of tasks that are marked as urgent.
struct UrgentTasksView: View {
    // The ViewModel is injected from the environment, making it easy to share task data across the app.
    @EnvironmentObject var tasksViewModel: TasksViewModel

    var body: some View {
        NavigationView {
            // The list iterates over the `urgentTasks` array published by the ViewModel.
            List(tasksViewModel.urgentTasks) { task in
                // Each task is rendered with its details.
                VStack(alignment: .leading, spacing: 8) {
                    Text(task.name)
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text(task.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Text("Исполнитель:")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(task.assignedTo ?? "Не назначен")
                            .font(.caption)
                            .fontWeight(.semibold)
                    }
                    
                    HStack {
                        Text("Срок:")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(task.endDate, style: .date)
                            .font(.caption)
                            .fontWeight(.semibold)
                    }
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Срочные задачи")
            // When the view appears, it triggers the ViewModel to fetch the urgent tasks.
            .onAppear {
                tasksViewModel.fetchUrgentTasks()
            }
        }
    }
}

// Preview provider for Xcode's canvas.
struct UrgentTasksView_Previews: PreviewProvider {
    static var previews: some View {
        // For the preview to work, a sample ViewModel must be provided as an environment object.
        UrgentTasksView()
            .environmentObject(TasksViewModel())
    }
}
