import SwiftUI
import Combine

final class CameraViewModel: ObservableObject {
    @Published var capturedImage: UIImage?
    @Published var isUploading = false
    @Published var uploadProgress: Double = 0.0
    @Published var uploadError: String?
    
    func captureImage(_ image: UIImage) {
        capturedImage = image
    }
    
    func uploadImage() {
        guard let image = capturedImage,
              let imageData = image.jpegData(compressionQuality: 0.8) else {
            uploadError = "Не удалось подготовить изображение для загрузки"
            return
        }
        
        isUploading = true
        uploadProgress = 0.0
        uploadError = nil
        
        // Используем правильный метод uploadImage из UploadService
        UploadService.shared.uploadImage(imageData) { [weak self] url in
            DispatchQueue.main.async {
                self?.isUploading = false
                
                if let url = url {
                    self?.uploadProgress = 1.0
                    print("Изображение успешно загружено: \(url)")
                } else {
                    self?.uploadError = "Ошибка загрузки изображения"
                }
            }
        }
        
        // Имитация прогресса загрузки
        simulateUploadProgress()
    }
    
    private func simulateUploadProgress() {
        // Имитация прогресса загрузки для демонстрации
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.3) { [weak self] in
                self?.uploadProgress = Double(i) * 0.1
            }
        }
    }
    
    func clearImage() {
        capturedImage = nil
        uploadError = nil
        uploadProgress = 0.0
    }
}
