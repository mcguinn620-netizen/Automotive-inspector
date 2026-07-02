import SwiftUI
import SwiftData

struct DashboardView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = CalendarViewModel()
    @State private var viewMode: ViewMode = .week
    
    enum ViewMode { case day, week, month }
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("View", selection: $viewMode) {
                    Text("Day").tag(ViewMode.day)
                    Text("Week").tag(ViewMode.week)
                    Text("Month").tag(ViewMode.month)
                }
                .pickerStyle(.segmented)
                .padding()
                
                // Ingestion Zone
                DropView()
                    .frame(height: 150)
                    .background(RoundedRectangle(cornerRadius: 12).fill(.ultraThinMaterial))
                    .padding()
                
                Spacer()
            }
            .navigationTitle("AI Calendar")
        }
    }
}

struct DropView: View {
    var body: some View {
        VStack {
            Image(systemName: "plus.viewfinder")
                .font(.largeTitle)
            Text("Drop screenshots or PDFs here")
                .font(.caption)
        }
        .onDrop(of: [.image, .pdf], isTargeted: nil) { providers in
            // Handle file ingestion logic here
            return true
        }
    }
}