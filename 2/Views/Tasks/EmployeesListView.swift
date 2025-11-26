import SwiftUI

struct EmployeesListView: View {
    @StateObject private var viewModel = EmployeesListViewModel()

    var body: some View {
        VStack {
            TextField("Поиск сотрудника...", text: $viewModel.searchText)
                .textFieldStyle(.roundedBorder)
                .padding()

            List(viewModel.filteredEmployees) { employee in
                HStack {
                    VStack(alignment: .leading) {
                        Text(employee.name)
                            .font(.headline)
                        Text(employee.role.rawValue.capitalized)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .navigationTitle("Сотрудники")
    }
}
