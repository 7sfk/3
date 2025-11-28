import SwiftUI

struct TasksView: View {
    @EnvironmentObject var viewModel: TasksViewModel
    @State private var showingAddTask = false

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.tasks) { task in
                    VStack(alignment: .leading) {
                        Text(task.name)
                            .font(.headline)
                        Text(task.description ?? "")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .onDelete(perform: viewModel.deleteTask)
            }
            .navigationTitle("Задачи")
            .navigationBarItems(trailing: 
                HStack {
                    Button(action: { showingAddTask = true }) {
                        Image(systemName: "plus")
                    }
                    EditButton()
                }
            )
            .sheet(isPresented: $showingAddTask) {
                AddTaskView()
                    .environmentObject(viewModel)
            }
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
            .environmentObject(TasksViewModel())
    }
}
