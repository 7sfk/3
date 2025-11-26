import SwiftUI

struct InventoryManagementView: View {
    @StateObject private var inventoryService = InventoryService()
    @State private var selectedCategory: MaterialCategory = .paints
    @State private var showingAddTransaction = false
    @State private var showingLowStockAlert = false
    
    var body: some View {
        VStack {
            // Заголовок с уведомлениями
            InventoryHeaderView(
                lowStockCount: inventoryService.getLowStockItems().count,
                onAlertTap: { showingLowStockAlert = true }
            )
            
            // Фильтр по категориям
            CategoryFilterView(selectedCategory: $selectedCategory)
            
            // Список материалов
            InventoryListView(
                items: filteredItems,
                onItemTap: { item in
                    // Показать детали предмета
                }
            )
        }
        .navigationTitle("Управление складом")
        .navigationBarItems(trailing: addButton)
        .sheet(isPresented: $showingAddTransaction) {
            AddTransactionView(onSave: { transaction in
                inventoryService.addTransaction(transaction)
            })
        }
        .onAppear {
            inventoryService.loadSampleData()
        }
    }
    
    private var filteredItems: [InventoryItem] {
        inventoryService.inventoryItems.filter { $0.category == selectedCategory }
    }
    
    private var addButton: some View {
        Button(action: { showingAddTransaction = true }) {
            Image(systemName: "plus.circle.fill")
                .font(.title2)
        }
    }
}

struct InventoryHeaderView: View {
    let lowStockCount: Int
    let onAlertTap: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Складские запасы")
                        .font(.title2)
                        .bold()
                    Text("Контроль материалов и поставок")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                
                if lowStockCount > 0 {
                    AlertBadge(count: lowStockCount, onTap: onAlertTap)
                }
            }
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

struct AlertBadge: View {
    let count: Int
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                Text("\(count)")
                    .fontWeight(.bold)
            }
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.red)
            .cornerRadius(20)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct CategoryFilterView: View {
    @Binding var selectedCategory: MaterialCategory
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(MaterialCategory.allCases, id: \.self) { category in
                    CategoryButton(
                        category: category,
                        isSelected: selectedCategory == category,
                        onTap: { selectedCategory = category }
                    )
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 8)
    }
}

struct CategoryButton: View {
    let category: MaterialCategory
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 4) {
                Image(systemName: category.icon)
                    .font(.system(size: 20))
                Text(category.displayName)
                    .font(.system(size: 10))
                    .multilineTextAlignment(.center)
            }
            .foregroundColor(isSelected ? .white : .primary)
            .frame(width: 80, height: 60)
            .background(isSelected ? Color.blue : Color.gray.opacity(0.2))
            .cornerRadius(12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct InventoryListView: View {
    let items: [InventoryItem]
    let onItemTap: (InventoryItem) -> Void
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(items) { item in
                    InventoryItemCard(item: item)
                        .onTapGesture {
                            onItemTap(item)
                        }
                }
            }
            .padding()
        }
    }
}

struct InventoryItemCard: View {
    let item: InventoryItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.name)
                        .font(.headline)
                    Text(item.category.displayName)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                // Индикатор запасов
                StockIndicator(
                    current: item.currentStock,
                    min: item.minStockLevel,
                    unit: item.unit
                )
            }
            
            HStack {
                Label(item.storageLocation, systemImage: "location")
                    .font(.caption)
                Spacer()
                if let supplier = item.supplier {
                    Label(supplier, systemImage: "building.2")
                        .font(.caption)
                }
            }
            .foregroundColor(.secondary)
            
            if item.isLowStock {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.red)
                    Text("Низкий запас! Заказать")
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(item.isLowStock ? Color.red : Color.clear, lineWidth: 1)
        )
    }
}

struct StockIndicator: View {
    let current: Double
    let min: Double
    let unit: String
    
    private var stockLevel: StockLevel {
        if current <= min {
            return .low
        } else if current <= min * 2 {
            return .medium
        } else {
            return .high
        }
    }
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 2) {
            Text("\(current, specifier: "%.0f") \(unit)")
                .font(.headline)
                .foregroundColor(stockLevel.color)
            Text("мин: \(min, specifier: "%.0f")")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}

enum StockLevel {
    case low, medium, high
    
    var color: Color {
        switch self {
        case .low: return .red
        case .medium: return .orange
        case .high: return .green
        }
    }
}

// Заглушки для остальных View
struct AddTransactionView: View {
    let onSave: (InventoryTransaction) -> Void
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Text("Форма добавления транзакции")
                .navigationTitle("Новая операция")
                .navigationBarItems(
                    leading: Button("Отмена") { dismiss() },
                    trailing: Button("Сохранить") {
                        // Сохранить транзакцию
                        dismiss()
                    }
                )
        }
    }
}
