import SwiftUI

// MARK: - ViewModel
class AdminDashboardViewModel: ObservableObject {
    @Published var projects: [ProjectContainer] = []
    @Published var isLoading = false
    private let firebaseService = FirebaseService.shared
    
    func fetchAllProjects() {
        isLoading = true
        // Загружаем все проекты, т.к. админ видит всё
        firebaseService.fetchProjects(forUser: "admin1", role: .admin) { [weak self] projects in
            DispatchQueue.main.async {
                self?.projects = projects
                self?.isLoading = false
            }
        }
    }
}

// MARK: - Admin Dashboard View
struct AdminDashboardView: View {
    @StateObject private var viewModel = AdminDashboardViewModel()
    @State private var isCreatingProject = false

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Загрузка проектов...")
            } else {
                List(viewModel.projects) { project in
                    ProjectRow(project: project)
                }
            }
        }
        .navigationTitle("Панель Администратора")
        .toolbar {
            Button(action: { isCreatingProject = true }) {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $isCreatingProject, onDismiss: viewModel.fetchAllProjects) {
            CreateProjectView()
        }
        .onAppear {
            viewModel.fetchAllProjects()
        }
    }
}

struct ProjectRow: View {
    let project: ProjectContainer
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(project.name).font(.headline)
            Text(project.address).font(.subheadline).foregroundColor(.secondary)
        }
    }
}


// MARK: - Create Project View
struct CreateProjectView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name: String = ""
    @State private var address: String = ""
    @State private var budget: String = ""
    @State private var isLoading = false
    
    private let firebaseService = FirebaseService.shared
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Основная информация")) {
                    TextField("Название проекта", text: $name)
                    TextField("Адрес объекта", text: $address)
                    TextField("Бюджет", text: $budget)
                        .keyboardType(.numberPad)
                }
                
                Button(action: createProject) {
                    if isLoading {
                        ProgressView()
                    } else {
                        Text("Создать проект")
                    }
                }
                .disabled(name.isEmpty || address.isEmpty || budget.isEmpty || isLoading)
            }
            .navigationTitle("Новый проект")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") { dismiss() }
                }
            }
        }
    }
    
    private func createProject() {
        guard let budgetValue = Double(budget) else { return }
        isLoading = true
        firebaseService.createProject(name: name, address: address, budget: budgetValue) { success in
            isLoading = false
            if success {
                dismiss()
            }
        }
    }
}
