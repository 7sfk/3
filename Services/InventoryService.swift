import SwiftUI
import Combine

class InventoryService: ObservableObject {
    @Published var inventoryItems: [InventoryItem] = []
    @Published var transactions: [InventoryTransaction] = []
    
    // Загрузка тестовых данных
    func loadSampleData() {
        inventoryItems = [
            InventoryItem(
                id: "1",
                name: "Краска белая",
                category: .paints,
                unit: "банка",
                minStockLevel: 5,
                currentStock: 4,
                supplier: "Текс",
                storageLocation: "Склад А",
                createdAt: Date(),
                updatedAt: Date()
            ),
            InventoryItem(
                id: "2",
                name: "Краска синяя",
                category: .paints,
                unit: "банка",
                minStockLevel: 3,
                currentStock: 8,
                supplier: "Текс",
                storageLocation: "Склад А",
                createdAt: Date(),
                updatedAt: Date()
            ),
            InventoryItem(
                id: "3",
                name: "Цемент М500",
                category: .constructionMaterials,
                unit: "мешок",
                minStockLevel: 20,
                currentStock: 15,
                supplier: "Лафарж",
                storageLocation: "Склад Б",
                createdAt: Date(),
                updatedAt: Date()
            )
        ]
        
        transactions = [
            InventoryTransaction(
                id: "1",
                itemId: "1",
                type: .outgoing,
                quantity: 2,
                date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
                projectId: "1",
                userId: "worker1",
                userName: "Иван Рабочий",
                notes: "Выдано для покраски стен в офисе",
                photoURLs: [],
                videoURLs: [],
                location: "55.7558, 37.6173",
                signature: "worker1_signature"
            )
        ]
    }
    
    // Добавление транзакции и обновление запасов
    func addTransaction(_ transaction: InventoryTransaction) {
        transactions.insert(transaction, at: 0)
        
        // Обновляем количество на складе
        if let index = inventoryItems.firstIndex(where: { $0.id == transaction.itemId }) {
            var item = inventoryItems[index]
            
            switch transaction.type {
            case .incoming:
                item.currentStock += transaction.quantity
            case .outgoing, .writeOff:
                item.currentStock -= transaction.quantity
            case .transfer, .adjustment:
                // Для этих типов логика может быть сложнее
                break
            }
            
            item.updatedAt = Date()
            inventoryItems[index] = item
        }
    }
    
    // Получение низких запасов
    func getLowStockItems() -> [InventoryItem] {
        return inventoryItems.filter { $0.isLowStock }
    }
    
    // Получение истории по предмету
    func getItemHistory(_ itemId: String) -> [InventoryTransaction] {
        return transactions.filter { $0.itemId == itemId }
    }
    
    // Получение предметов по категории
    func getItemsByCategory(_ category: MaterialCategory) -> [InventoryItem] {
        return inventoryItems.filter { $0.category == category }
    }
}
