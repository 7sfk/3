import Foundation

struct InventoryItem: Identifiable, Codable {
    let id: String
    let name: String
    let category: MaterialCategory
    let unit: String // шт, кг, л, банка и т.д.
    let minStockLevel: Double
    var currentStock: Double
    let supplier: String?
    let storageLocation: String
    let createdAt: Date
    var updatedAt: Date
    
    var isLowStock: Bool {
        currentStock <= minStockLevel
    }
}

enum MaterialCategory: String, CaseIterable, Codable {
    case paints = "paints"
    case constructionMaterials = "construction_materials"
    case tools = "tools"
    case equipment = "equipment"
    case electrical = "electrical"
    case plumbing = "plumbing"
    case safety = "safety"
    
    var displayName: String {
        switch self {
        case .paints: return "Лакокрасочные материалы"
        case .constructionMaterials: return "Строительные материалы"
        case .tools: return "Инструменты"
        case .equipment: return "Оборудование"
        case .electrical: return "Электрика"
        case .plumbing: return "Сантехника"
        case .safety: return "СИЗ и безопасность"
        }
    }
    
    var icon: String {
        switch self {
        case .paints: return "paintbrush"
        case .constructionMaterials: return "cube"
        case .tools: return "wrench"
        case .equipment: return "gearshape"
        case .electrical: return "bolt"
        case .plumbing: return "drop"
        case .safety: return "shield"
        }
    }
}
