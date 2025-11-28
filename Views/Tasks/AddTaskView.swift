import SwiftUI

struct AddTaskView: View {
    @EnvironmentObject var viewModel: TasksViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var taskName: String = ""
    @State private var taskDescription: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Название задачи", text: $taskName)
                TextField("Описание", text: $taskDescription)
            }
            .navigationTitle("Новая задача")
            .navigationBarItems(leading: Button("Отмена") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Сохранить") {
                let newTask = ProjectTask(id: UUID().uuidString, name: taskName, description: taskDescription, isCompleted: false, assignedTo: "", timeline: DateInterval())
                viewModel.addTask(newTask)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
            .environmentObject(TasksViewModel())
    }
}
