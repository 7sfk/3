import SwiftUI

// Общие компоненты для использования во всем приложении

struct StatusBadge: View {
    let status: ContainerProjectStatus
    
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

extension ContainerProjectStatus {
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
