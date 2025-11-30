import SwiftUI

struct LoginView: View {
    // The ViewModel contains all the logic and state for this view.
    @ObservedObject var viewModel: LoginViewModel

    var body: some View {
        NavigationView {
            VStack(spacing: 18) {
                // Header with app icon and name
                VStack(spacing: 8) {
                    Image(systemName: "building.2.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.accentColor)
                    Text("CONSTRUCT AI")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                    Text("Ваш архитектурный помощник")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 40)

                Text("Вход в систему")
                    .font(.title2).bold()
                    .padding(.top)

                // Input fields for username and password
                VStack(spacing: 12) {
                    TextField("Имя пользователя", text: $viewModel.username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .textContentType(.username)
                        .autocapitalization(.none)

                    SecureField("Пароль", text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .textContentType(.password)
                }
                .padding(.horizontal)

                // Role selection
                VStack(alignment: .leading, spacing: 8) {
                    Text("Выберите вашу роль:")
                        .font(.headline)
                    Picker("Роль", selection: $viewModel.selectedRole) {
                        ForEach(UserRole.allCases, id: \.self) { role in
                            Text(role.rawValue.capitalized).tag(role)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(.horizontal)

                // Error message display
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                // Login button with loading state
                Button(action: viewModel.login) {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text("Войти")
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
                .disabled(viewModel.isLoading)

                Spacer()
                
                // Demo helper text
                VStack(spacing: 4) {
                    Text("Для демонстрации:")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("Используйте любое имя и пароль.")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom)
            }
            .navigationBarHidden(true)
            .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        }
    }
}

// This preview block helps visualize the LoginView in Xcode's canvas.
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        // We create a mock LoginViewModel for the preview.
        let mockViewModel = LoginViewModel(appState: AppState())
        return LoginView(viewModel: mockViewModel)
    }
}
