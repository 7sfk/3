import Foundation
import Combine

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isIncoming: Bool
}

final class MessagesViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var newMessageText: String = ""

    func sendMessage() {
        guard !newMessageText.isEmpty else { return }

        let msg = ChatMessage(text: newMessageText, isIncoming: false)
        messages.append(msg)

        newMessageText = ""
    }
}

