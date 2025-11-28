import Foundation

class UploadService {
    static let shared = UploadService()
    
    private init() {}
    
    func uploadImage(_ imageData: Data, completion: @escaping (String?) -> Void) {
        // Заглушка для загрузки изображения
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completion("https://example.com/image\(Int.random(in: 1...1000)).jpg")
        }
    }
    
    func uploadFile(_ fileURL: URL, completion: @escaping (String?) -> Void) {
        // Заглушка для загрузки файла
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completion("https://example.com/file\(Int.random(in: 1...1000)).pdf")
        }
    }
    
    // Альтернативное имя метода для обратной совместимости
    func upload(_ imageData: Data, completion: @escaping (String?) -> Void) {
        uploadImage(imageData, completion: completion)
    }
}
