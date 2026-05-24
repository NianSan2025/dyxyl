import Foundation

struct StudyTask: Identifiable, Codable {
    let id: UUID
    var studentId: String
    var title: String
    var category: TaskCategory
    var estimatedMinutes: Int
    var status: TaskStatus
    var createdAt: Date
    var completedAt: Date?

    init(
        id: UUID = UUID(),
        studentId: String,
        title: String,
        category: TaskCategory,
        estimatedMinutes: Int,
        status: TaskStatus = .pending,
        createdAt: Date = Date(),
        completedAt: Date? = nil
    ) {
        self.id = id
        self.studentId = studentId
        self.title = title
        self.category = category
        self.estimatedMinutes = estimatedMinutes
        self.status = status
        self.createdAt = createdAt
        self.completedAt = completedAt
    }
}

enum TaskCategory: String, Codable, CaseIterable {
    case recitation = "recitation"   // 背诵
    case math = "math"               // 数学
    case freeReview = "freeReview"   // 自由复习

    var displayName: String {
        switch self {
        case .recitation: return "背诵"
        case .math: return "数学"
        case .freeReview: return "自由复习"
        }
    }
}

enum TaskStatus: String, Codable {
    case pending = "pending"
    case inProgress = "in_progress"
    case completed = "completed"
}