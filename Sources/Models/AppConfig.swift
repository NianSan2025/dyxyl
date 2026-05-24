import Foundation

struct AppConfig: Codable {
    var studentId: String
    var whiteListApps: [String]     // bundleIds
    var permanentWhiteListApps: [String]  // bundleIds
    var studyTimeRangeStart: String?  // HH:mm
    var studyTimeRangeEnd: String?    // HH:mm
    var isParentMode: Bool

    init(
        studentId: String = "default",
        whiteListApps: [String] = [],
        permanentWhiteListApps: [String] = [],
        studyTimeRangeStart: String? = nil,
        studyTimeRangeEnd: String? = nil,
        isParentMode: Bool = false
    ) {
        self.studentId = studentId
        self.whiteListApps = whiteListApps
        self.permanentWhiteListApps = permanentWhiteListApps
        self.studyTimeRangeStart = studyTimeRangeStart
        self.studyTimeRangeEnd = studyTimeRangeEnd
        self.isParentMode = isParentMode
    }
}