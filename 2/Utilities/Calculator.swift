import Foundation

class Calculator {
    
    static func calculateMaterials(for area: Double, materialRate: Double) -> Double {
        // Расчет необходимого объема материалов
        return area * materialRate
    }
    
    static func calculateCost(materialCost: Double, laborCost: Double) -> Double {
        return materialCost + laborCost
    }
}
