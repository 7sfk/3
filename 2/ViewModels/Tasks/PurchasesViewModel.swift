import SwiftUI

struct PurchaseItem: Identifiable {
    var id: String
    var title: String
    var assignedTo: String
}

class PurchasesViewModel: ObservableObject {
    @Published var purchases: [PurchaseItem] = []

    init() {
        purchases = [
            PurchaseItem(id: "1", title: "Закупить материалы", assignedTo: "Иван"),
            PurchaseItem(id: "2", title: "Проверка склада", assignedTo: "Алексей")
        ]
    }
}

struct PurchasesView: View {
    @ObservedObject var viewModel: PurchasesViewModel

    var body: some View {
        List(viewModel.purchases) { purchase in
            VStack(alignment: .leading) {
                Text(purchase.title)
                    .font(.headline)
                Text("Ответственный: \(purchase.assignedTo)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle("Покупки")
    }
}
