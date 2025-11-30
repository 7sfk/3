import SwiftUI

struct ProjectMetricsView: View {
    @ObservedObject var projectVM: ProjectViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "chart.xyaxis.line")
                    .foregroundColor(.green)
                Text("Метрики Проекта")
                    .font(.headline)
                Spacer()
                Text("📊")
                    .font(.title2)
            }
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 12) {
                MetricCard(
                    title: "Выполнение",
                    value: "\(projectVM.metrics.completionPercentage)%",
                    icon: "checkmark.circle",
                    color: .blue,
                    progress: Double(projectVM.metrics.completionPercentage) / 100
                )
                
                MetricCard(
                    title: "Бюджет",
                    value: "\(projectVM.metrics.budgetUtilization)%",
                    icon: "dollarsign.circle",
                    color: .green,
                    progress: Double(projectVM.metrics.budgetUtilization) / 100
                )
                
                MetricCard(
                    title: "График",
                    value: "\(projectVM.metrics.timelineAdherence)%",
                    icon: "clock",
                    color: .orange,
                    progress: Double(projectVM.metrics.timelineAdherence) / 100
                )
                
                MetricCard(
                    title: "Качество",
                    value: "\(projectVM.metrics.qualityScore)%",
                    icon: "star.circle",
                    color: .purple,
                    progress: Double(projectVM.metrics.qualityScore) / 100
                )
            }
        }
        .padding()
        .background(Color.green.opacity(0.1))
        .cornerRadius(12)
    }
}

struct MetricCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    let progress: Double
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.caption)
                Spacer()
                Text(value)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.primary)
            }
            
            Text(title)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ProgressView(value: progress)
                .progressViewStyle(LinearProgressViewStyle(tint: color))
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: .gray.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}
