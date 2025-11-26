import Foundation
import UIKit

class FileManagerUtil {
    
    static func saveImage(_ image: UIImage, to path: String) -> Bool {
        guard let data = image.pngData() else { return false }
        do {
            let url = URL(fileURLWithPath: path)
            try data.write(to: url)
            return true
        } catch {
            print("Ошибка сохранения файла: \(error)")
            return false
        }
    }
    
    static func fileExists(at path: String) -> Bool {
        return FileManager.default.fileExists(atPath: path)
    }
    
    static func loadFile(at path: String) -> Data? {
        return FileManager.default.contents(atPath: path)
    }
}

