import SwiftUI

struct UserHeaderView: View {
    @EnvironmentObject var appState: AppState  // Используем AppState вместо ProjectAccessService
    
    var body: some View {
        VStack(alignment: .leading) {
            if let user = appState.currentUser {  // Берем пользователя из AppState
                HStack {
                    VStack(alignment: .leading) {
                        Text("Добро пожаловать, \(user)")
                            .font(.title2)
                            .bold()
                        Text("\(appState.currentUserRole.displayName)")  // Берем роль из AppState
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.blue)
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(12)
            }
        }
        .padding(.horizontal)
    }
}
