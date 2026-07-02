import AppIntents
import SwiftData

struct ScheduleEventIntent: AppIntent {
    static var title: LocalizedStringResource = "Schedule Event"
    
    @Parameter(title: "Details")
    var naturalLanguageInput: String
    
    func perform() async throws -> some IntentResult {
        // Logic to parse naturalLanguageInput (e.g., using NaturalLanguage framework)
        // and save to SwiftData
        return .result()
    }
}

struct AppShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: ScheduleEventIntent(),
            phrases: ["Schedule a meeting with \(.applicationName)"],
            shortTitle: "Schedule Event",
            systemImageName: "calendar.badge.plus"
        )
    }
}