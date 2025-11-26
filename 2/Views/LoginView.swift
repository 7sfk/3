import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel

    var body: some View {
        VStack(spacing: 18) {
            Text("CONSTRUCT AI")
                .font(.system(size: 28, weight: .bold, design: .rounded))

            Text("Вход в систему")
                .font(.title3)

            TextField("Имя пользователя", text: $viewModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            SecureField("Пароль", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            Picker("Роль", selection: $viewModel.selectedRole) {
                Text("Прораб").tag(UserRole.foreman)
                Text("Админ").tag(UserRole.admin)
                Text("Рабочий").tag(UserRole.worker)
                Text("Снабженец").tag(UserRole.supplier)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)

            if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
            }

            Button(action: { viewModel.login() }) {
                Text("Войти")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.cornerRadius(10))
                    .foregroundColor(.white)
                    .padding(.horizontal)
            }

            Spacer()
        }
        .padding(.top, 40)
    }
}
