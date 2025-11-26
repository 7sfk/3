import SwiftUI

struct TasksListView: View {
    @ObservedObject var viewModel: TasksViewModel

    var body: some View {
        List {
            ForEach(viewModel.tasks) { task in
                HStack {
                    VStack(alignment: .leading) {
                        Text(task.title)
                            .font(.headline)
                        Text(task.description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Text("\(Int(task.progress * 100))%")
                        .foregroundColor(.blue)
                }
            }
        }
        .navigationTitle("Задачи")
    }
}
