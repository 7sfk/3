import SwiftUI

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
        case .manager:
            return .red
        case .supervisor:
            return .orange
        case .engineer:
            return .blue
        case .architect:
            return .purple
        case .worker:
            return .green
        }
    }
}
