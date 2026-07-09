import Foundation
import EventKit
import SwiftData

@Observable
final class EventSyncManager {
    private let eventStore = EKEventStore()
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(storeChanged), name: .EKEventStoreChanged, object: eventStore)
    }
    
    @objc private func storeChanged() {
        // Logic to pull changes from native calendar to SwiftData
    }
    
    func pushToCalendar(_ event: CalendarEvent) {
        eventStore.requestFullAccessToEvents { granted, _ in
            guard granted else { return }
            let ekEvent = EKEvent(eventStore: self.eventStore)
            ekEvent.title = event.title
            ekEvent.startDate = event.date
            ekEvent.endDate = event.date.addingTimeInterval(3600)
            ekEvent.calendar = self.eventStore.defaultCalendarForNewEvents
            try? self.eventStore.save(ekEvent, span: .thisEvent)
            event.isSynced = true
        }
    }
}