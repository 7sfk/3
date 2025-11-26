import SwiftUI

struct DetailView: View {
    @EnvironmentObject var appState: AppState
    let title: String

    var body: some View {
        VStack(spacing: 16) {
            Text(title)
                .font(.largeTitle)
                .bold()

            Text("Здесь будет детальная информация по разделу \"\(title)\".")
                .foregroundColor(.gray)

            Spacer()
        }
        .padding()
    }
}

