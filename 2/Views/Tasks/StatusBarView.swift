import SwiftUI
import Foundation

enum EmployeeRole: String, Codable {
    case admin, foreman, worker
}

struct StatusBarView: View {
    @Binding var currentUserRole: EmployeeRole

    var body: some View {
        HStack {
            Text("Текущая роль:")
            Text(currentUserRole.rawValue.capitalized)
                .foregroundColor(roleColor(role: currentUserRole))
                .bold()
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }

    private func roleColor(role: EmployeeRole) -> Color {
        switch role {
        case .admin: return .red
        case .foreman: return .blue
        case .worker: return .green
        }
    }
}
