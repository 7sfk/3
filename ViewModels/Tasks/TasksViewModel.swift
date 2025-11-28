import SwiftUI
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

// This ViewModel is responsible for fetching and managing the list of tasks from Firestore.
final class TasksViewModel: ObservableObject {
    // The list of tasks that will be displayed in the view.
    @Published var tasks: [ProjectTask] = []
    
    // A reference to the Firestore database.
    private var db = Firestore.firestore()
    
    // Holds the registration for the Firestore listener, so we can detach it later.
    private var listenerRegistration: ListenerRegistration?

    // Fetches tasks from the "tasks" collection in Firestore in real-time.
    func fetchTasks() {
        // Remove any existing listener to avoid duplicates.
        listenerRegistration?.remove()
        
        // Attach a snapshot listener to the "tasks" collection.
        // This closure will be called whenever the data changes on the server.
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
            
            // Decode the Firestore documents into our `ProjectTask` model.
            // `compactMap` is used to discard any documents that fail to decode.
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
    
    // The deinitializer is called when the ViewModel is no longer in use.
    // It's important to remove the listener to prevent memory leaks.
    deinit {
        listenerRegistration?.remove()
    }
}
