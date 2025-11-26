import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel

    var body: some View {
        NavigationView {
            VStack(spacing: 18) {
                // Заголовок с иконкой
                VStack(spacing: 8) {
                    Image(systemName: "building.2")
                        .font(.system(size: 50))
                        .foregroundColor(.blue)
                    Text("CONSTRUCT AI")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                    Text("Архитектурный помощник")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 40)

                Text("Вход в систему")
                    .font(.title3)
                    .bold()

                // Поля ввода
                VStack(spacing: 12) {
                    TextField("Имя пользователя", text: $viewModel.username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)

                    SecureField("Пароль", text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.horizontal)

                // Выбор роли
                VStack(alignment: .leading, spacing: 8) {
                    Text("Роль:")
                        .font(.headline)
                    Picker("Роль", selection: $viewModel.selectedRole) {
                        Text("Прораб").tag(UserRole.foreman)
                        Text("Админ").tag(UserRole.admin)
                        Text("Рабочий").tag(UserRole.worker)
                        Text("Снабженец").tag(UserRole.supplier)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(.horizontal)

                // Сообщение об ошибке
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.horizontal)
                }

                // Кнопка входа
                Button(action: { 
                    viewModel.login() 
                }) {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text("Войти")
                            .font(.headline)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
                .disabled(viewModel.isLoading)

                // Демо подсказка
                VStack(spacing: 4) {
                    Text("Для теста:")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("Любой логин, пароль от 3 символов")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                .padding(.top)

                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}
