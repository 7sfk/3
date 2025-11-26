import Foundation
import SwiftUI
import Combine

class CameraViewModel: ObservableObject {
    @Published var capturedImage: UIImage? = nil
    @Published var uploadStatus: String = ""

    func captureImage() {
        capturedImage = UIImage(systemName: "camera.fill")
        uploadStatus = "Изображение захвачено"
    }

    func uploadImage() {
        guard let image = capturedImage,
              let imageData = image.jpegData(compressionQuality: 0.8) else {
            uploadStatus = "Нет изображения для загрузки"
            return
        }

        UploadService.shared.upload(fileData: imageData) { success in
            DispatchQueue.main.async {
                self.uploadStatus = success ? "Загрузка успешна" : "Ошибка загрузки"
            }
        }
    }
}
