import Foundation

class Calculator {
    static func calculateArea(length: Double, width: Double) -> Double {
        return length * width
    }
    
    static func calculateVolume(length: Double, width: Double, height: Double) -> Double {
        return length * width * height
    }
    
    static func estimateMaterials(area: Double, materialType: String) -> Double {
        // Простая оценка материалов
        switch materialType {
        case "concrete": return area * 0.1
        case "bricks": return area * 50
        case "paint": return area * 0.01
        default: return area * 0.05
        }
    }
}
