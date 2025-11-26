import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var projectVM = ProjectViewModel()
    @StateObject private var tasksVM = TasksViewModel()
    @State private var selectedTab = 0

    var body: some View {
        NavigationView {
            VStack {
                // Верхняя панель быстрых действий
                QuickActionsView(projectVM: projectVM)
                
                TabView(selection: $selectedTab) {
                    // Главная панель
                    ScrollView {
                        VStack(spacing: 16) {
                            ProjectMetricsView(projectVM: projectVM)
                            AIRecommendationsView(projectVM: projectVM)
                            UrgentTasksView(tasksVM: tasksVM)
                        }
                        .padding()
                    }
                    .tag(0)
                    
                    // Аналитика команды
                    TeamAnalyticsView()
                        .tag(1)
                    
                    // Архитектурные стандарты
                    ArchitectureStandardsView()
                        .tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                // Индикаторы вкладок
                CustomTabIndicator(selectedTab: $selectedTab)
            }
            .navigationTitle("Архитектурный Помощник")
            .navigationBarItems(
                trailing: HStack {
                    Button(action: { generateProjectReport() }) {
                        Image(systemName: "doc.text")
                    }
                    Button(action: { projectVM.analyzeRisks() }) {
                        Image(systemName: "exclamationmark.triangle")
                    }
                }
            )
        }
    }
    
    private func generateProjectReport() {
        // Генерация отчета
        print("Генерация отчета...")
    }
}

struct CustomTabIndicator: View {
    @Binding var selectedTab: Int
    let tabs = ["Проект", "Команда", "Стандарты"]
    
    var body: some View {
        HStack {
            ForEach(0..<tabs.count, id: \.self) { index in
                Text(tabs[index])
                    .font(.caption)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(selectedTab == index ? Color.blue : Color.gray.opacity(0.2))
                    .foregroundColor(selectedTab == index ? .white : .primary)
                    .cornerRadius(20)
                    .onTapGesture {
                        selectedTab = index
                    }
            }
        }
        .padding()
    }
}

struct QuickActionsView: View {
    @ObservedObject var projectVM: ProjectViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                QuickActionButton(
                    icon: "chart.bar",
                    title: "Анализ",
                    color: .blue,
                    action: { projectVM.analyzeRisks() }
                )
                
                QuickActionButton(
                    icon: "person.2",
                    title: "Команда", 
                    color: .green,
                    action: { }
                )
                
                QuickActionButton(
                    icon: "building.2",
                    title: "Стандарты",
                    color: .orange,
                    action: { }
                )
                
                QuickActionButton(
                    icon: "clock",
                    title: "График",
                    color: .purple,
                    action: { }
                )
            }
            .padding(.horizontal)
        }
    }
}

struct QuickActionButton: View {
    let icon: String
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.white)
                Text(title)
                    .font(.caption2)
                    .foregroundColor(.white)
            }
            .frame(width: 70, height: 60)
            .background(color)
            .cornerRadius(12)
        }
    }
}
