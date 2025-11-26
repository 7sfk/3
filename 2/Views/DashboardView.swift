import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var appState: AppState
    @State private var searchText: String = ""
    @State private var selectedStatTitle: String? = nil

    let demoCards = [
        ("Задачи", "12/20", Color.blue, "checkmark.seal"),
        ("Проекты", "3", Color.purple, "square.grid.2x2"),
        ("Склад", "34 позиции", Color.green, "archivebox"),
        ("Сообщения", "7", Color.orange, "message")
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                HStack {
                    Text("Привет, \(appState.currentUser?.name ?? "Гость")")
                        .font(.headline)
                    Spacer()
                    Text(appState.currentUser?.role.rawValue ?? "")
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)

                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Поиск сотрудников или задач", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                }
                .padding(.horizontal)

                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(demoCards, id: \.0) { card in
                            Button {
                                selectedStatTitle = card.0
                            } label: {
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Image(systemName: card.3)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 34, height: 34)
                                            .padding(8)
                                            .background(card.2.opacity(0.15))
                                            .cornerRadius(8)

                                        Spacer()
                                        Text(card.1)
                                            .bold()
                                            .foregroundColor(.white)
                                    }

                                    Text(card.0)
                                        .foregroundColor(.white.opacity(0.9))

                                    Capsule()
                                        .frame(height: 6)
                                        .foregroundColor(card.2)
                                }
                                .padding()
                                .background(Color.primary.opacity(0.08))
                                .cornerRadius(12)
                                .shadow(radius: 6)
                            }
                        }
                    }
                    .padding()
                }

                Spacer()
            }
            .navigationDestination(isPresented: Binding(get: { selectedStatTitle != nil }, set: { if !$0 { selectedStatTitle = nil } })) {
                if let t = selectedStatTitle {
                    DetailView(title: t)
                        .environmentObject(appState)
                }
            }
            .navigationTitle("Дашборд")
        }
    }
}
