import Foundation

enum Constants {
    enum Task {
        static let defaultStudyMinutes = 45
        static let breakMinutes = 5
    }

    enum Storage {
        static let tasksKey = "study_tasks"
        static let schedulesKey = "schedules"
        static let configKey = "app_config"
    }

    enum Time {
        static let format = "HH:mm"
    }
}