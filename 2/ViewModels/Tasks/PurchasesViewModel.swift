import SwiftUI
import Combine

final class PurchasesViewModel: ObservableObject {
    @Published var purchases: [Purchase] = []

    init() {
        purchases = [
            Purchase(id: "1", item: "Бетон", quantity: 10, assignedTo: "3"),
            Purchase(id: "2", item: "Песок", quantity: 20, assignedTo: "4")
        ]
    }
}
