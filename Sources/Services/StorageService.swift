import Foundation

class StorageService {
    static let shared = StorageService()

    private let defaults = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    private init() {}

    // MARK: - StudyTasks

    func saveTasks(_ tasks: [StudyTask]) {
        if let data = try? encoder.encode(tasks) {
            defaults.set(data, forKey: Constants.Storage.tasksKey)
        }
    }

    func loadTasks() -> [StudyTask] {
        guard let data = defaults.data(forKey: Constants.Storage.tasksKey),
              let tasks = try? decoder.decode([StudyTask].self, from: data) else {
            return []
        }
        return tasks
    }

    // MARK: - Schedules

    func saveSchedules(_ schedules: [Schedule]) {
        if let data = try? encoder.encode(schedules) {
            defaults.set(data, forKey: Constants.Storage.schedulesKey)
        }
    }

    func loadSchedules() -> [Schedule] {
        guard let data = defaults.data(forKey: Constants.Storage.schedulesKey),
              let schedules = try? decoder.decode([Schedule].self, from: data) else {
            return []
        }
        return schedules
    }

    // MARK: - Config

    func saveConfig(_ config: AppConfig) {
        if let data = try? encoder.encode(config) {
            defaults.set(data, forKey: Constants.Storage.configKey)
        }
    }

    func loadConfig() -> AppConfig? {
        guard let data = defaults.data(forKey: Constants.Storage.configKey),
              let config = try? decoder.decode(AppConfig.self, from: data) else {
            return nil
        }
        return config
    }
}