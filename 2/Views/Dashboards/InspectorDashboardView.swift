import SwiftUI

// MARK: - ViewModel
class InspectorDashboardViewModel: ObservableObject {
    @Published var tasks: [ProjectTask] = []
    @Published var isLoading = false
    private let firebaseService = FirebaseService.shared
    let projectId: String
    
    init(projectId: String) {
        self.projectId = projectId
        fetchAllTasks()
    }
    
    func fetchAllTasks() {
        isLoading = true
        firebaseService.fetchAllTasks(for: projectId) { [weak self] tasks in
            DispatchQueue.main.async {
                self?.tasks = tasks
                self?.isLoading = false
            }
        }
    }
    
    func addRemark(to taskId: String, remark: String) {
        firebaseService.addRemark(to: taskId, remark: remark) { [weak self] success in
            if success {
                self?.fetchAllTasks() // Перезагружаем задачи, чтобы увидеть новое замечание
            }
        }
    }
}

// MARK: - Inspector Dashboard View
struct InspectorDashboardView: View {
    @StateObject private var viewModel: InspectorDashboardViewModel
    @State private var selectedTask: ProjectTask?
    
    init(project: ProjectContainer) {
        _viewModel = StateObject(wrappedValue: InspectorDashboardViewModel(projectId: project.id))
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading && viewModel.tasks.isEmpty {
                ProgressView("Загрузка задач...")
            } else {
                List(viewModel.tasks) { task in
                    TaskWithRemarksRow(task: task) {
                        selectedTask = task // Показываем окно добавления замечания для этой задачи
                    }
                }
            }
        }
        .navigationTitle("Панель Инспектора")
        .sheet(item: $selectedTask) { task in
            AddRemarkView(task: task, viewModel: viewModel)
        }
    }
}

// MARK: - Task Row with Remarks
struct TaskWithRemarksRow: View {
    let task: ProjectTask
    let onAddRemark: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(task.name)
                    .font(.headline)
                Spacer()
                Button(action: onAddRemark) {
                    Image(systemName: "plus.message.fill")
                }
            }
            Text(task.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            if !task.remarks.isEmpty {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Замечания:").bold()
                    ForEach(task.remarks, id: \.self) { remark in
                        Text("• \(remark)")
                            .font(.caption)
                    }
                }
                .padding(.top, 4)
            }
        }
        .padding(.vertical, 8)
    }
}

// MARK: - Add Remark View
struct AddRemarkView: View {
    @Environment(\.dismiss) var dismiss
    @State private var remarkText: String = ""
    
    let task: ProjectTask
    @ObservedObject var viewModel: InspectorDashboardViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Добавить замечание к задаче:")
                    .font(.headline)
                    .padding()
                Text(task.name)
                    .font(.title2)
                    .padding(.bottom)
                
                TextEditor(text: $remarkText)
                    .border(Color.gray, width: 1)
                    .padding()
                
                Button("Сохранить") {
                    viewModel.addRemark(to: task.id, remark: remarkText)
                    dismiss()
                }
                .disabled(remarkText.isEmpty)
                .padding()
                
                Spacer()
            }
            .navigationTitle("Новое замечание")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") { dismiss() }
                }
            }
        }
    }
}
