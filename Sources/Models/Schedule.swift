import Foundation

struct Schedule: Identifiable, Codable {
    let id: UUID
    var studentId: String
    var date: Date
    var timeSlots: [TimeSlot]

    init(
        id: UUID = UUID(),
        studentId: String,
        date: Date,
        timeSlots: [TimeSlot]
    ) {
        self.id = id
        self.studentId = studentId
        self.date = date
        self.timeSlots = timeSlots
    }
}

struct TimeSlot: Identifiable, Codable {
    let id: UUID
    var startTime: String  // HH:mm
    var endTime: String    // HH:mm
    var taskId: UUID?
    var status: TimeSlotStatus

    init(
        id: UUID = UUID(),
        startTime: String,
        endTime: String,
        taskId: UUID? = nil,
        status: TimeSlotStatus = .scheduled
    ) {
        self.id = id
        self.startTime = startTime
        self.endTime = endTime
        self.taskId = taskId
        self.status = status
    }
}

enum TimeSlotStatus: String, Codable {
    case scheduled = "scheduled"
    case inProgress = "in_progress"
    case completed = "completed"
    case breakTime = "break"
}