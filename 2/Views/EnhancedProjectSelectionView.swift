import SwiftUI

struct EnhancedProjectSelectionView: View {
    @EnvironmentObject var accessService: ProjectAccessService
    @EnvironmentObject var appState: AppState
    @State private var selectedProject: ProjectContainer?
    @State private var showingLogoutAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Фон с градиентом
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Улучшенная шапка пользователя
                    EnhancedUserHeaderView()
                    
                    // Заголовок секции
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Мои проекты")
                            .font(.title2)
                            .bold()
                        Text("Доступно проектов: \(accessService.getUserProjects().count)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                    
                    // Список проектов
                    if accessService.getUserProjects().isEmpty {
                        EmptyProjectsView()
                    } else {
                        ProjectsListView(selectedProject: $selectedProject)
                    }
                    
                    Spacer()
                    
                    // Кнопка выхода
                    Button(action: {
                        showingLogoutAlert = true
                    }) {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                            Text("Выйти")
                        }
                        .foregroundColor(.red)
                        .padding()
                    }
                }
            }
            .navigationBarHidden(true)
            .alert("Выход из системы", isPresented: $showingLogoutAlert) {
                Button("Отмена", role: .cancel) { }
                Button("Выйти", role: .destructive) {
                    appState.logout()
                }
            } message: {
                Text("Вы уверены, что хотите выйти?")
            }
            .onAppear {
                accessService.loadSampleData()
            }
        }
    }
}

struct EnhancedUserHeaderView: View {
    @EnvironmentObject var accessService: ProjectAccessService
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Добро пожаловать!")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    if let user = accessService.currentUser {
                        Text(user)
                            .font(.title2)
                            .bold()
                            .foregroundColor(.primary)
                    }
                    
                    HStack {
                        Image(systemName: "person.badge.shield.checkmark.fill")
                            .foregroundColor(roleColor)
                        Text(accessService.currentUserRole.displayName)
                            .font(.subheadline)
                            .foregroundColor(roleColor)
                    }
                }
                
                Spacer()
                
                // Аватар с иконкой роли
                ZStack {
                    Circle()
                        .fill(roleColor.opacity(0.2))
                        .frame(width: 60, height: 60)
                    
                    Image(systemName: roleIcon)
                        .font(.title2)
                        .foregroundColor(roleColor)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
        .padding(.horizontal)
        .padding(.top)
    }
    
    private var roleColor: Color {
        switch accessService.currentUserRole {
        case .admin: return .red
        case .foreman: return .orange
        case .supplier: return .blue
        case .worker: return .green
        case .inspector: return .purple
        }
    }
    
    private var roleIcon: String {
        switch accessService.currentUserRole {
        case .admin: return "crown.fill"
        case .foreman: return "person.fill.viewfinder"
        case .supplier: return "shippingbox.fill"
        case .worker: return "hammer.fill"
        case .inspector: return "checkmark.shield.fill"
        }
    }
}

struct EmptyProjectsView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "tray.fill")
                .font(.system(size: 50))
                .foregroundColor(.gray)
            
            Text("Нет доступных проектов")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text("Обратитесь к администратору для получения доступа к проектам")
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

struct ProjectsListView: View {
    @EnvironmentObject var accessService: ProjectAccessService
    @Binding var selectedProject: ProjectContainer?
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(accessService.getUserProjects()) { project in
                    NavigationLink(destination: RoleBasedProjectView(project: project)) {
                        EnhancedProjectCardView(
                            project: project,
                            isSelected: selectedProject?.id == project.id
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
        }
    }
}

struct EnhancedProjectCardView: View {
    let project: ProjectContainer
    let isSelected: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Заголовок и статус
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(project.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(project.address)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                StatusBadge(status: project.status)
            }
            
            // Описание
            Text(project.description)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(2)
            
            // Метрики
            HStack {
                MetricView(icon: "calendar", value: formatDate(project.timeline.plannedEndDate))
                Spacer()
                MetricView(icon: "rublesign.circle", value: formatBudget(project.budget))
                Spacer()
                MetricView(icon: "person.2", value: "\(project.assignedUsers.count) чел.")
            }
            
            // Прогресс (если есть)
            if project.status == .inProgress {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("Прогресс")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("35%") // Заглушка - в реальном приложении брать из данных
                            .font(.caption)
                            .bold()
                    }
                    
                    ProgressView(value: 0.35)
                        .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
        )
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

struct StatusBadge: View {
    let status: ProjectStatus
    
    var body: some View {
        Text(status.displayName)
            .font(.system(size: 12, weight: .medium))
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(statusColor)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
    
    private var statusColor: Color {
        switch status {
        case .planning: return .orange
        case .inProgress: return .blue
        case .onHold: return .red
        case .completed: return .green
        case .cancelled: return .gray
        }
    }
}

struct MetricView: View {
    let icon: String
    let value: String
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 12))
                .foregroundColor(.secondary)
            Text(value)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.primary)
        }
    }
}

extension ProjectStatus {
    var displayName: String {
        switch self {
        case .planning: return "Планирование"
        case .inProgress: return "В работе"
        case .onHold: return "На паузе"
        case .completed: return "Завершен"
        case .cancelled: return "Отменен"
        }
    }
}
