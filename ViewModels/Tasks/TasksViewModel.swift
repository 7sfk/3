
import SwiftUI
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

final class TasksViewModel: ObservableObject {
    @Published var tasks: [ProjectTask] = []
    private var db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?

    func fetchTasks() {
        listenerRegistration?.remove() // Remove previous listener
        
        listenerRegistration = db.collection("tasks").addSnapshotListener { [weak self] (querySnapshot, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error getting tasks: \(error.localizedDescription)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No documents in 'tasks' collection")
                return
            }
            
            self.tasks = documents.compactMap { document -> ProjectTask? in
                do {
                    return try document.data(as: ProjectTask.self)
                } catch {
                    print("Error decoding task: \(error.localizedDescription)")
                    return nil
                }
            }
        }
    }
    
    deinit {
        listenerRegistration?.remove()
    }
}
