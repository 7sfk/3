import SwiftUI

struct StatusBarView: View {
    @Binding var currentUserRole: UserRole

    var body: some View {
        HStack {
            Text("Текущая роль:")
            Text(currentUserRole.displayName)
                .foregroundColor(roleColor(role: currentUserRole))
                .bold()
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }

    private func roleColor(role: UserRole) -> Color {
        switch role {
        case .admin:
            return .red
        case .foreman:
            return .orange
        case .supplier:
            return .blue
        case .worker:
            return .green
        case .inspector:
            return .purple
        }
    }
}
