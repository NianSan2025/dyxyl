import Foundation
import Combine

class AppConfigViewModel: ObservableObject {
    @Published var config: AppConfig

    init() {
        if let saved = StorageService.shared.loadConfig() {
            config = saved
        } else {
            config = AppConfig()
            saveConfig()
        }
    }

    func updateStudyTimeRange(start: String, end: String) {
        config.studyTimeRangeStart = start
        config.studyTimeRangeEnd = end
        saveConfig()
    }

    func addWhiteListApp(bundleId: String) {
        if !config.whiteListApps.contains(bundleId) {
            config.whiteListApps.append(bundleId)
            saveConfig()
        }
    }

    func addPermanentWhiteListApp(bundleId: String) {
        if !config.permanentWhiteListApps.contains(bundleId) {
            config.permanentWhiteListApps.append(bundleId)
            saveConfig()
        }
    }

    func toggleParentMode(_ isParent: Bool) {
        config.isParentMode = isParent
        saveConfig()
    }

    private func saveConfig() {
        StorageService.shared.saveConfig(config)
    }
}