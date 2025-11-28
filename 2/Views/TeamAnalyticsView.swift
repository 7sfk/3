import SwiftUI

struct TeamAnalyticsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Аналитика команды")
                    .font(.title2)
                    .bold()
                
                // Заглушки для аналитики команды
                AnalyticsPlaceholder(title: "Распределение по ролям", icon: "person.3")
                AnalyticsPlaceholder(title: "Загрузка сотрудников", icon: "chart.bar")
                AnalyticsPlaceholder(title: "Продуктивность", icon: "speedometer")
            }
            .padding()
        }
    }
}

struct AnalyticsPlaceholder: View {
    let title: String
    let icon: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(.blue)
            Text(title)
                .font(.headline)
            Text("Данные анализируются AI...")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(12)
    }
}
