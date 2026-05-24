import Foundation
import Combine

class ScheduleViewModel: ObservableObject {
    @Published var schedules: [Schedule] = []

    init() {
        loadSchedules()
    }

    func loadSchedules() {
        schedules = StorageService.shared.loadSchedules()
    }

    func createSchedule(studentId: String, date: Date, timeSlots: [TimeSlot]) {
        let schedule = Schedule(
            studentId: studentId,
            date: date,
            timeSlots: timeSlots
        )
        schedules.append(schedule)
        saveSchedules()
    }

    func getSchedule(for date: Date, studentId: String) -> Schedule? {
        let calendar = Calendar.current
        return schedules.first {
            $0.studentId == studentId &&
            calendar.isDate($0.date, inSameDayAs: date)
        }
    }

    func updateSlotStatus(scheduleId: UUID, slotIndex: Int, status: TimeSlotStatus) {
        if let index = schedules.firstIndex(where: { $0.id == scheduleId }) {
            schedules[index].timeSlots[slotIndex].status = status
            saveSchedules()
        }
    }

    private func saveSchedules() {
        StorageService.shared.saveSchedules(schedules)
    }
}