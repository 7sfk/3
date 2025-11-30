import SwiftUI

struct ProjectSelectionView: View {
    @EnvironmentObject var accessService: ProjectAccessService
    @EnvironmentObject var appState: AppState  // Добавляем AppState
    @State private var selectedProject: ProjectContainer?
    
    var body: some View {
        NavigationView {
            VStack {
                // Шапка с информацией о пользователе
                UserHeaderView()
                
                // Список доступных проектов
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(accessService.availableProjects) { project in  // Исправлено: используем свойство вместо метода
                            ProjectCardView(project: project, isSelected: selectedProject?.id == project.id)
                                .onTapGesture {
                                    selectedProject = project
                                }
                        }
                    }
                    .padding()
                }
                
                // Кнопка перехода к выбранному проекту
                if let project = selectedProject {
                    NavigationLink(destination: RoleBasedProjectView(project: project)) {
                        Text("Перейти к проекту: \(project.name)")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    .padding()
                }
                
                Spacer()
            }
            .navigationTitle("Мои проекты")
            .onAppear {
                // Исправлено: передаем роль и пользователя из AppState
                if let user = appState.currentUser {
                    accessService.loadSampleData(for: appState.currentUserRole, user: user)
                }
            }
        }
    }
}

struct ProjectCardView: View {
    let project: ProjectContainer
    let isSelected: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading) {
                    Text(project.name)
                        .font(.headline)
                    Text(project.address)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                
                // Статус проекта
                Text(project.status.rawValue)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(statusColor)
                    .foregroundColor(.white)
                    .cornerRadius(4)
            }
            
            Text(project.description)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(2)
            
            HStack {
                Text("Бюджет: \(formatBudget(project.budget))")
                    .font(.caption)
                Spacer()
                Text("Срок: \(formatDate(project.timeline.plannedEndDate))")
                    .font(.caption)
            }
        }
        .padding()
        .background(isSelected ? Color.blue.opacity(0.1) : Color.gray.opacity(0.1))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
        )
    }
    
    private var statusColor: Color {
        switch project.status {
        case .planning: return .orange
        case .inProgress: return .blue
        case .onHold: return .red
        case .completed: return .green
        case .cancelled: return .gray
        }
    }
    
    private func formatBudget(_ budget: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "₽"
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: budget)) ?? "\(budget)₽"
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        return formatter.string(from: date)
    }
}
