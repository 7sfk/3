import Foundation
import SwiftUI

class UploadService {
    static let shared = UploadService() // Синглтон для общего доступа

    private init() {} // Приватный init чтобы нельзя было создать другой объект

    func upload(fileData: Data, completion: @escaping (Bool) -> Void) {
        // Заглушка загрузки файла на сервер
        print("Загружаем файл на сервер (симуляция)")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(true) // имитируем успешную загрузку
        }
    }
}
