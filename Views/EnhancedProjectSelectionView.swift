import SwiftUI

struct EnhancedProjectSelectionView: View {
    @EnvironmentObject var projectAccessService: ProjectAccessService
    @EnvironmentObject var appState: AppState
    @State private var selectedProjectId: String? = nil
    @State private var navigateToMainMenu = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Заголовок
                VStack(spacing: 8) {
                    Text("Выбор проекта")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Выберите проект для работы")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 40)
                
                // Список проектов
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(projectAccessService.availableProjects) { projectContainer in
                            ProjectCard(
                                projectContainer: projectContainer,
                                isSelected: selectedProjectId == projectContainer.id,
                                onSelect: {
                                    selectedProjectId = projectContainer.id
                                    // Конвертируем ProjectContainer в Project
                                    let project = Project(
                                        name: projectContainer.name,
                                        description: projectContainer.description,
                                        status: .active,
                                        progress: 0
                                    )
                                    projectAccessService.selectProject(project)
                                }
                            )
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Кнопка продолжения
                if selectedProjectId != nil {
                    NavigationLink(destination: MainMenuView(), isActive: $navigateToMainMenu) {
                        Button(action: {
                            navigateToMainMenu = true
                        }) {
                            HStack {
                                Text("Перейти к проекту")
                                Image(systemName: "arrow.right")
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}

struct ProjectCard: View {
    let projectContainer: ProjectContainer
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        Button(action: onSelect) {
            HStack(spacing: 15) {
                // Иконка проекта
                Image(systemName: "building.2.fill")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background(Color.blue)
                    .clipShape(Circle())
                
                // Информация о проекте
                VStack(alignment: .leading, spacing: 4) {
                    Text(projectContainer.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(projectContainer.description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                    
                    HStack {
                        Label("0%", systemImage: "chart.line.uptrend.xyaxis")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Text(projectContainer.status.rawValue)
                            .font(.caption2)
                            .padding(4)
                            .background(statusColor)
                            .foregroundColor(.white)
                            .cornerRadius(4)
                    }
                }
                
                Spacer()
                
                // Индикатор выбора
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.blue)
                        .font(.title2)
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .gray.opacity(0.1), radius: 3, x: 0, y: 1)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
            )
        }
    }
    
    private var statusColor: Color {
        switch projectContainer.status {
        case .planning: return .orange
        case .inProgress: return .green
        case .onHold: return .gray
        case .completed: return .blue
        case .cancelled: return .red
        }
    }
}

#Preview {
    EnhancedProjectSelectionView()
        .environmentObject(ProjectAccessService())
        .environmentObject(AppState())
}
