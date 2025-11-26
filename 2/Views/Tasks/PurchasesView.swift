import SwiftUI

struct PurchasesView: View {
    @StateObject private var viewModel = PurchasesViewModel()

    var body: some View {
        List(viewModel.purchases) { purchase in
            VStack(alignment: .leading) {
                Text(purchase.item)
                    .font(.headline)
                HStack {
                    Text("Кол-во: \(purchase.quantity)")
                    Spacer()
                    Text("Назначено: \(purchase.assignedTo)")
                }
                .font(.subheadline)
                .foregroundColor(.gray)
            }
        }
        .navigationTitle("Закупки")
    }
}
