import SwiftUI

// This view displays a list of employees, with search and add capabilities.
struct EmployeesListView: View {
    // The ViewModel is provided by the environment, allowing it to be shared with other views like AddEmployeeView.
    @EnvironmentObject var viewModel: EmployeeViewModel
    
    // State to control the presentation of the "Add Employee" sheet.
    @State private var showingAddEmployee = false

    var body: some View {
        VStack {
            // Search bar for filtering employees.
            // The text is bound to the `searchText` property in the ViewModel.
            TextField("Поиск сотрудника...", text: $viewModel.searchText)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            // The list of employees.
            // It iterates over `filteredEmployees`, which the ViewModel is responsible for updating based on the search text.
            List(viewModel.filteredEmployees) { employee in
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
        // The "+" button in the navigation bar triggers the `showingAddEmployee` state.
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showingAddEmployee = true }) {
                    Image(systemName: "plus")
                }
            }
        }
        // When `showingAddEmployee` is true, the AddEmployeeView is presented as a sheet.
        .sheet(isPresented: $showingAddEmployee) {
            // The sheet is given its own navigation view for a proper title and buttons.
            NavigationView {
                AddEmployeeView()
                    .environmentObject(viewModel) // The same ViewModel is passed to the sheet.
            }
        }
    }
}

// Preview provider for Xcode's canvas.
struct EmployeesListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EmployeesListView()
                .environmentObject(EmployeeViewModel()) // Provide a mock ViewModel for the preview.
        }
    }
}
