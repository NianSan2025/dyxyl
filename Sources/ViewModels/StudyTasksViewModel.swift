import Foundation
import Combine

class StudyTasksViewModel: ObservableObject {
    @Published var tasks: [StudyTask] = []

    init() {
        loadTasks()
    }

    func loadTasks() {
        tasks = StorageService.shared.loadTasks()
    }

    func addTask(studentId: String, title: String, category: TaskCategory, estimatedMinutes: Int) {
        let task = StudyTask(
            studentId: studentId,
            title: title,
            category: category,
            estimatedMinutes: estimatedMinutes
        )
        tasks.append(task)
        saveTasks()
    }

    func updateStatus(taskId: UUID, status: TaskStatus) {
        if let index = tasks.firstIndex(where: { $0.id == taskId }) {
            tasks[index].status = status
            if status == .completed {
                tasks[index].completedAt = Date()
            }
            saveTasks()
        }
    }

    func pendingTasks(studentId: String) -> [StudyTask] {
        tasks.filter { $0.studentId == studentId && $0.status == .pending }
    }

    private func saveTasks() {
        StorageService.shared.saveTasks(tasks)
    }
}