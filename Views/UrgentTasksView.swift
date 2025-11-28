
import SwiftUI

struct UrgentTasksView: View {
    @StateObject private var tasksViewModel = TasksViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(tasksViewModel.tasks.filter { $0.status == "Urgent" }) { task in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(task.name)
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Text(task.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        HStack {
                            Text("Assigned to:")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text(task.assignedTo ?? "Unassigned")
                                .font(.caption)
                                .fontWeight(.semibold)
                        }
                        
                        HStack {
                            Text("Due Date:")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text(task.endDate, style: .date)
                                .font(.caption)
                                .fontWeight(.semibold)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("Urgent Tasks")
            .onAppear {
                tasksViewModel.fetchTasks()
            }
        }
    }
}

struct UrgentTasksView_Previews: PreviewProvider {
    static var previews: some View {
        UrgentTasksView()
    }
}
