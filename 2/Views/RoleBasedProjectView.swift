import SwiftUI

struct RoleBasedProjectView: View {
    let project: ProjectContainer
    @EnvironmentObject var appState: AppState
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            ProjectHeaderView(project: project)
            
            switch appState.currentUserRole {
            case .admin:
                AdminProjectView(project: project)
            case .foreman:
                ForemanProjectView(project: project)
            case .supplier:
                SupplierProjectView(project: project)
            case .worker:
                WorkerProjectView(project: project)
            case .inspector:
                InspectorProjectView(project: project)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
    
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Назад")
            }
            .foregroundColor(.blue)
        }
    }
}

struct ProjectHeaderView: View {
    let project: ProjectContainer
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(project.name)
                        .font(.title2)
                        .bold()
                    Text(project.address)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                
                StatusBadge(status: project.status)
            }
            
            Text(project.description)
                .font(.body)
                .foregroundColor(.primary)
        }
        .padding()
        .background(Color.blue.opacity(0.05))
    }
}

// MARK: - Admin View
struct AdminProjectView: View {
    let project: ProjectContainer
    @State private var selectedTab = 0
    
    var body: some View {
        VStack {
            AdminTabBar(selectedTab: $selectedTab)
            
            TabView(selection: $selectedTab) {
                AdminDashboardView(project: project)
                    .tag(0)
                ProjectTeamManagementView(project: project)
                    .tag(1)
                ProjectFinancialsView(project: project)
                    .tag(2)
                ProjectSettingsView(project: project)
                    .tag(3)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}

struct AdminTabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                TabButton(title: "Дашборд", icon: "chart.bar", isSelected: selectedTab == 0) {
                    selectedTab = 0
                }
                TabButton(title: "Команда", icon: "person.3", isSelected: selectedTab == 1) {
                    selectedTab = 1
                }
                TabButton(title: "Финансы", icon: "dollarsign.circle", isSelected: selectedTab == 2) {
                    selectedTab = 2
                }
                TabButton(title: "Настройки", icon: "gear", isSelected: selectedTab == 3) {
                    selectedTab = 3
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 8)
        .background(Color.white)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.gray.opacity(0.3)),
            alignment: .bottom
        )
    }
}

// MARK: - Foreman View
struct ForemanProjectView: View {
    let project: ProjectContainer
    @State private var selectedTab = 0
    
    var body: some View {
        VStack {
            ForemanTabBar(selectedTab: $selectedTab)
            
            TabView(selection: $selectedTab) {
                ForemanTasksView(project: project)
                    .tag(0)
                TeamManagementView(project: project)
                    .tag(1)
                ProgressTrackingView(project: project)
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}

struct ForemanTabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            TabButton(title: "Задачи", icon: "checklist", isSelected: selectedTab == 0) {
                selectedTab = 0
            }
            TabButton(title: "Бригада", icon: "person.2", isSelected: selectedTab == 1) {
                selectedTab = 1
            }
            TabButton(title: "Прогресс", icon: "chart.line.uptrend.xyaxis", isSelected: selectedTab == 2) {
                selectedTab = 2
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

// MARK: - Worker View
struct WorkerProjectView: View {
    let project: ProjectContainer
    @State private var selectedTab = 0
    
    var body: some View {
        VStack {
            WorkerTabBar(selectedTab: $selectedTab)
            
            TabView(selection: $selectedTab) {
                MyTasksView(project: project)
                    .tag(0)
                WorkScheduleView(project: project)
                    .tag(1)
                ToolsView(project: project)
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}

struct WorkerTabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            TabButton(title: "Мои задачи", icon: "checklist", isSelected: selectedTab == 0) {
                selectedTab = 0
            }
            TabButton(title: "График", icon: "calendar", isSelected: selectedTab == 1) {
                selectedTab = 1
            }
            TabButton(title: "Инструменты", icon: "wrench.and.screwdriver", isSelected: selectedTab == 2) {
                selectedTab = 2
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

// MARK: - Supplier View
struct SupplierProjectView: View {
    let project: ProjectContainer
    @State private var selectedTab = 0
    
    var body: some View {
        VStack {
            SupplierTabBar(selectedTab: $selectedTab)
            
            TabView(selection: $selectedTab) {
                MaterialsView(project: project)
                    .tag(0)
                OrdersView(project: project)
                    .tag(1)
                InventoryView(project: project)
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}

struct SupplierTabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            TabButton(title: "Материалы", icon: "shippingbox", isSelected: selectedTab == 0) {
                selectedTab = 0
            }
            TabButton(title: "Заказы", icon: "cart", isSelected: selectedTab == 1) {
                selectedTab = 1
            }
            TabButton(title: "Склад", icon: "archivebox", isSelected: selectedTab == 2) {
                selectedTab = 2
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

// MARK: - Inspector View
struct InspectorProjectView: View {
    let project: ProjectContainer
    @State private var selectedTab = 0
    
    var body: some View {
        VStack {
            InspectorTabBar(selectedTab: $selectedTab)
            
            TabView(selection: $selectedTab) {
                QualityChecksView(project: project)
                    .tag(0)
                SafetyInspectionsView(project: project)
                    .tag(1)
                ReportsView(project: project)
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}

struct InspectorTabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            TabButton(title: "Контроль", icon: "checkmark.shield", isSelected: selectedTab == 0) {
                selectedTab = 0
            }
            TabButton(title: "Безопасность", icon: "exclamationmark.triangle", isSelected: selectedTab == 1) {
                selectedTab = 1
            }
            TabButton(title: "Отчеты", icon: "doc.text", isSelected: selectedTab == 2) {
                selectedTab = 2
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

// MARK: - Tab Button Component
struct TabButton: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .medium))
                Text(title)
                    .font(.system(size: 12, weight: .medium))
            }
            .foregroundColor(isSelected ? .blue : .gray)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(isSelected ? Color.blue.opacity(0.1) : Color.clear)
            .cornerRadius(8)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Заглушки для вьюшек
struct AdminDashboardView: View {
    let project: ProjectContainer
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Панель администратора")
                    .font(.title3)
                    .bold()
            }
            .padding()
        }
    }
}

struct ProjectTeamManagementView: View {
    let project: ProjectContainer
    var body: some View {
        Text("Управление командой проекта")
    }
}

struct ProjectFinancialsView: View {
    let project: ProjectContainer
    var body: some View {
        Text("Финансы проекта")
    }
}

struct ProjectSettingsView: View {
    let project: ProjectContainer
    var body: some View {
        Text("Настройки проекта")
    }
}

struct ForemanTasksView: View {
    let project: ProjectContainer
    var body: some View {
        Text("Управление задачами")
    }
}

struct TeamManagementView: View {
    let project: ProjectContainer
    var body: some View {
        Text("Управление бригадой")
    }
}

struct ProgressTrackingView: View {
    let project: ProjectContainer
    var body: some View {
        Text("Отслеживание прогресса")
    }
}

struct MyTasksView: View {
    let project: ProjectContainer
    var body: some View {
        Text("Мои задачи")
    }
}

struct WorkScheduleView: View {
    let project: ProjectContainer
    var body: some View {
        Text("График работ")
    }
}

struct ToolsView: View {
    let project: ProjectContainer
    var body: some View {
        Text("Инструменты и материалы")
    }
}

struct MaterialsView: View {
    let project: ProjectContainer
    var body: some View {
        Text("Управление материалами")
    }
}

struct OrdersView: View {
    let project: ProjectContainer
    var body: some View {
        Text("Заказы и поставки")
    }
}

struct InventoryView: View {
    let project: ProjectContainer
    var body: some View {
        Text("Складской учет")
    }
}

struct QualityChecksView: View {
    let project: ProjectContainer
    var body: some View {
        Text("Контроль качества")
    }
}

struct SafetyInspectionsView: View {
    let project: ProjectContainer
    var body: some View {
        Text("Проверки безопасности")
    }
}

struct ReportsView: View {
    let project: ProjectContainer
    var body: some View {
        Text("Отчеты и акты")
    }
}
