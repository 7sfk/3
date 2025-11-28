import SwiftUI

struct AddEmployeeView: View {
    @EnvironmentObject var viewModel: EmployeeViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var selectedRole: Role = .worker
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Имя сотрудника", text: $name)
                Picker("Роль", selection: $selectedRole) {
                    ForEach(Role.allCases) {
                        Text($0.displayName).tag($0)
                    }
                }
            }
            .navigationTitle("Новый сотрудник")
            .navigationBarItems(leading: Button("Отмена") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Сохранить") {
                let newEmployee = Employee(id: UUID().uuidString, name: name, role: selectedRole)
                viewModel.addEmployee(newEmployee)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddEmployeeView_Previews: PreviewProvider {
    static var previews: some View {
        AddEmployeeView()
            .environmentObject(EmployeeViewModel())
    }
}
