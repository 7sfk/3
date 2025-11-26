import SwiftUI

struct PurchasesView: View {
    @ObservedObject var viewModel: PurchasesViewModel

    var body: some View {
        List {
            ForEach(viewModel.purchases) { purchase in
                VStack(alignment: .leading) {
                    Text(purchase.itemName)
                        .font(.headline)
                    HStack {
                        Text("Кол-во: \(purchase.quantity)")
                        Spacer()
                        Text("Статус: \(purchase.status.rawValue.capitalized)")
                    }
                    .font(.subheadline)
                    .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle("Закупки")
    }
}
