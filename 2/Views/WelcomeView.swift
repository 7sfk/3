import SwiftUI

struct WelcomeView: View {
    let user: String
    let role: UserRole
    let onContinue: () -> Void
    
    @State private var showContent = false
    @State private var showWelcomeText = false
    
    var body: some View {
        ZStack {
            // Анимированный фон
            AnimatedBackground()
            
            VStack(spacing: 30) {
                Spacer()
                
                // Приветственная иконка
                WelcomeIconView(role: role)
                    .scaleEffect(showContent ? 1.0 : 0.5)
                    .opacity(showContent ? 1.0 : 0.0)
                
                // Текст приветствия
                VStack(spacing: 16) {
                    if showWelcomeText {
                        Text("Добро пожаловать!")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                            .transition(.scale.combined(with: .opacity))
                        
                        Text(user)
                            .font(.title2)
                            .foregroundColor(.white.opacity(0.9))
                        
                        Text(role.displayName)
                            .font(.headline)
                            .foregroundColor(roleColor)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(20)
                    }
                }
                
                Spacer()
                
                // Кнопка продолжения
                if showContent {
                    Button(action: onContinue) {
                        HStack {
                            Text("Начать работу")
                            Image(systemName: "arrow.right")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(roleColor)
                        .cornerRadius(15)
                        .shadow(color: roleColor.opacity(0.3), radius: 10, x: 0, y: 5)
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .padding()
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                showContent = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.easeInOut(duration: 0.8)) {
                    showWelcomeText = true
                }
            }
        }
    }
    
    private var roleColor: Color {
        switch role {
        case .admin: return .red
        case .foreman: return .orange
        case .supplier: return .blue
        case .worker: return .green
        case .inspector: return .purple
        }
    }
}

struct AnimatedBackground: View {
    @State private var rotation = 0.0
    
    var body: some View {
        ZStack {
            // Градиентный фон
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.blue.opacity(0.6),
                    Color.purple.opacity(0.4),
                    Color.blue.opacity(0.2)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Анимированные фигуры
            ForEach(0..<3) { index in
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.white.opacity(0.1),
                                Color.white.opacity(0.05)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 200 + CGFloat(index * 100))
                    .offset(
                        x: cos(Double(index) * 2.0 + rotation) * 50,
                        y: sin(Double(index) * 2.0 + rotation) * 50
                    )
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
                rotation = 2 * .pi
            }
        }
    }
}

struct WelcomeIconView: View {
    let role: UserRole
    
    var body: some View {
        ZStack {
            Circle()
                .fill(roleColor.opacity(0.2))
                .frame(width: 120, height: 120)
            
            Circle()
                .fill(roleColor.opacity(0.4))
                .frame(width: 80, height: 80)
            
            Image(systemName: roleIcon)
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.white)
        }
    }
    
    private var roleColor: Color {
        switch role {
        case .admin: return .red
        case .foreman: return .orange
        case .supplier: return .blue
        case .worker: return .green
        case .inspector: return .purple
        }
    }
    
    private var roleIcon: String {
        switch role {
        case .admin: return "crown.fill"
        case .foreman: return "person.fill.viewfinder"
        case .supplier: return "shippingbox.fill"
        case .worker: return "hammer.fill"
        case .inspector: return "checkmark.shield.fill"
        }
    }
}
