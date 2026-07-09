import Foundation
import SwiftData

@Model
final class CalendarEvent {
    var title: String
    var date: Date
    var location: String?
    var isSynced: Bool
    
    init(title: String, date: Date, location: String? = nil) {
        self.title = title
        self.date = date
        self.location = location
        self.isSynced = false
    }
}