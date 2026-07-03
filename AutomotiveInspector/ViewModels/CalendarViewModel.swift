import SwiftUI
import SwiftData
import EventKit

@Observable
final class CalendarViewModel {
    var events: [CalendarEvent] = []
    private let eventStore = EKEventStore()
    
    func addEvent(_ event: CalendarEvent, context: ModelContext) {
        context.insert(event)
        // Optional: Sync to native calendar
        syncToNativeCalendar(event)
    }
    
    private func syncToNativeCalendar(_ event: CalendarEvent) {
        eventStore.requestFullAccessToEvents { granted, _ in
            guard granted else { return }
            let newEvent = EKEvent(eventStore: self.eventStore)
            newEvent.title = event.title
            newEvent.startDate = event.date
            newEvent.endDate = event.date.addingTimeInterval(3600)
            newEvent.calendar = self.eventStore.defaultCalendarForNewEvents
            try? self.eventStore.save(newEvent, span: .thisEvent)
        }
    }
}