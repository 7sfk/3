import SwiftUI

struct ArchitectureStandardsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Архитектурные стандарты")
                    .font(.title2)
                    .bold()
                
                StandardCard(
                    title: "SP 70.13330.2012",
                    description: "Несущие конструкции",
                    status: .compliant
                )
                
                StandardCard(
                    title: "SP 118.13330.2012", 
                    description: "Общественные здания",
                    status: .pending
                )
                
                StandardCard(
                    title: "СП 59.13330.2016",
                    description: "Доступность для маломобильных",
                    status: .nonCompliant
                )
            }
            .padding()
        }
    }
}

struct StandardCard: View {
    let title: String
    let description: String
    let status: ComplianceStatus
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: status.icon)
                .font(.title2)
                .foregroundColor(status.color)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(status.rawValue)
                .font(.caption)
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(status.color)
                .cornerRadius(4)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: .gray.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}

enum ComplianceStatus: String {
    case compliant = "Соответствует"
    case pending = "На проверке"
    case nonCompliant = "Не соответствует"
    
    var color: Color {
        switch self {
        case .compliant: return .green
        case .pending: return .orange
        case .nonCompliant: return .red
        }
    }
    
    var icon: String {
        switch self {
        case .compliant: return "checkmark.circle.fill"
        case .pending: return "clock.fill"
        case .nonCompliant: return "xmark.circle.fill"
        }
    }
}
