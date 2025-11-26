import SwiftUI

struct UserHeaderView: View {
    @EnvironmentObject var accessService: ProjectAccessService
    
    var body: some View {
        VStack(alignment: .leading) {
            if let user = accessService.currentUser {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Добро пожаловать, \(user)")
                            .font(.title2)
                            .bold()
                        Text("\(accessService.currentUserRole.displayName)")
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
