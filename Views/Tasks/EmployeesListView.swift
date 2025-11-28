import SwiftUI

struct EmployeesListView: View {
    @EnvironmentObject var viewModel: EmployeeViewModel
    @State private var showingAddEmployee = false

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.employees) { employee in
                    VStack(alignment: .leading) {
                        Text(employee.name)
                            .font(.headline)
                        Text(employee.role.displayName)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Сотрудники")
            .navigationBarItems(trailing: Button(action: { showingAddEmployee = true }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingAddEmployee) {
                AddEmployeeView()
                    .environmentObject(viewModel)
            }
        }
    }
}

struct EmployeesListView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeesListView()
            .environmentObject(EmployeeViewModel())
    }
}
