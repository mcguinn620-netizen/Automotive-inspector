import Foundation
import Vision
import PDFKit
import NaturalLanguage

struct EventDraft {
    var title: String
    var date: Date
}

protocol EventExtractor {
    func extract(from data: Data) async throws -> String
}

struct ExtractionService {
    static func normalize(text: String) -> EventDraft {
        // Use NLTokenizer or simple regex to extract date/title
        return EventDraft(title: "Inspection", date: Date())
    }
}