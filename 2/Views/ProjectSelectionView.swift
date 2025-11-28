import SwiftUI

struct ProjectSelectionView: View {
    @EnvironmentObject var accessService: ProjectAccessService
    @EnvironmentObject var appState: AppState
    @State private var selectedProject: ProjectContainer?

    var body: some View {
        NavigationView {
            VStack {
                UserHeaderView()

                if accessService.isLoading {
                    ProgressView("Загрузка проектов...")
                    Spacer()
                } else if accessService.availableProjects.isEmpty {
                    Text("Проекты не найдены.")
                        .foregroundColor(.secondary)
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(accessService.availableProjects) { project in
                                ProjectCardView(project: project, isSelected: selectedProject?.id == project.id)
                                    .onTapGesture {
                                        selectedProject = project
                                    }
                            }
                        }
                        .padding()
                    }
                }

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
                if let user = appState.currentUser {
                    accessService.fetchProjects(forUser: user, role: appState.currentUserRole)
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
