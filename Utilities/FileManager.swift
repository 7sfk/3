import Foundation

class AppFileManager {
    static let shared = AppFileManager()
    
    private init() {}
    
    func saveImage(_ imageData: Data, name: String) -> URL? {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documents.appendingPathComponent("\(name).jpg")
        
        do {
            try imageData.write(to: fileURL)
            return fileURL
        } catch {
            print("Error saving image: \(error)")
            return nil
        }
    }
    
    func loadImage(name: String) -> Data? {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documents.appendingPathComponent("\(name).jpg")
        
        return try? Data(contentsOf: fileURL)
    }
}
