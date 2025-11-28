import SwiftUI

struct UrgentTasksView: View {
    @EnvironmentObject var tasksViewModel: TasksViewModel

    var body: some View {
        NavigationView {
            List(tasksViewModel.urgentTasks) { task in
                VStack(alignment: .leading) {
                    Text(task.name)
                        .font(.headline)
                    Text(task.description ?? "No description")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Срочные задачи")
            .onAppear {
                tasksViewModel.fetchUrgentTasks()
            }
        }
    }
}

struct UrgentTasksView_Previews: PreviewProvider {
    static var previews: some View {
        UrgentTasksView()
            .environmentObject(TasksViewModel())
    }
}
