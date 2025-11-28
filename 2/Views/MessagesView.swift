import SwiftUI

struct MessagesView: View {
    var body: some View {
        VStack {
            Text("Сообщения")
                .font(.title)
                .padding()
            
            Text("Здесь будет система сообщений и коммуникации")
                .foregroundColor(.secondary)
            
            Spacer()
        }
        .navigationTitle("Сообщения")
    }
}

#Preview {
    MessagesView()
}
