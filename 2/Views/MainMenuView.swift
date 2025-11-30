import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var projectAccessService: ProjectAccessService
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Заголовок
                    VStack {
                        Text("Архитектурный Помощник")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        if let user = appState.currentUser {
                            Text("Добро пожаловать, \(user)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.top)
                    
                    // Основные функции
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        NavigationLink(destination: DashboardView()) {
                            MenuCard(
                                icon: "chart.bar.fill",
                                title: "Дашборд",
                                color: .blue,
                                description: "Обзор проекта"
                            )
                        }
                        
                        NavigationLink(destination: TimeTrackingView()) {
                            MenuCard(
                                icon: "stopwatch.fill",
                                title: "Учет времени",
                                color: .green,
                                description: "Рабочее время"
                            )
                        }
                        
                        NavigationLink(destination: TasksListView()) {
                            MenuCard(
                                icon: "checklist",
                                title: "Задачи",
                                color: .orange,
                                description: "Управление задачами"
                            )
                        }
                        
                        NavigationLink(destination: InventoryManagementView()) {
                            MenuCard(
                                icon: "cube.box.fill",
                                title: "Инвентарь",
                                color: .purple,
                                description: "Материалы и запасы"
                            )
                        }
                        
                        NavigationLink(destination: MessagesView()) {
                            MenuCard(
                                icon: "message.fill",
                                title: "Сообщения",
                                color: .red,
                                description: "Коммуникация"
                            )
                        }
                        
                        NavigationLink(destination: CameraView()) {
                            MenuCard(
                                icon: "camera.fill",
                                title: "Камера",
                                color: .indigo,
                                description: "Фото и документы"
                            )
                        }
                    }
                    .padding(.horizontal)
                    
                    // Дополнительные функции
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Дополнительно")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        AdditionalMenuRow(icon: "chart.line.uptrend.xyaxis", title: "Аналитика", action: {})
                        AdditionalMenuRow(icon: "doc.text.fill", title: "Отчеты", action: {})
                        AdditionalMenuRow(icon: "gear", title: "Настройки", action: {})
                    }
                    .padding(.top)
                }
            }
            .navigationTitle("Главное меню")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MenuCard: View {
    let icon: String
    let title: String
    let color: Color
    let description: String
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .background(color)
                .clipShape(Circle())
            
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(description)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(height: 140)
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}

struct AdditionalMenuRow: View {
    let icon: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                    .frame(width: 30)
                
                Text(title)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(8)
            .padding(.horizontal)
        }
    }
}
