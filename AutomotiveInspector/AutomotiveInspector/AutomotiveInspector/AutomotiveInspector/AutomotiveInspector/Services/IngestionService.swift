import Vision
import PDFKit
import UIKit

struct IngestionService {
    static func extractText(from image: UIImage) async throws -> String {
        guard let cgImage = image.cgImage else { return "" }
        let requestHandler = VNImageRequestHandler(cgImage: cgImage)
        let request = VNRecognizeTextRequest()
        try requestHandler.perform([request])
        return request.results?.compactMap { $0.topCandidates(1).first?.string }.joined(separator: "\n") ?? ""
    }
    
    static func extractText(from pdfData: Data) -> String {
        guard let pdf = PDFDocument(data: pdfData) else { return "" }
        return (0..<pdf.pageCount).compactMap { pdf.page(at: $0)?.string }.joined(separator: "\n")
    }
}