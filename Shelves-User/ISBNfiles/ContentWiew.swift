import SwiftUI

struct ContentWiew: View {
    @State private var scannedCode: String?
    @State private var bookDetails: Books?
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var showScanner: Bool = true

    var body: some View {
        VStack {
            if showScanner {
                BarcodeScannerView(scannedCode: $scannedCode, onCodeScanned: {
                    if let code = scannedCode {
                        fetchBookDetails(isbn: code)
                    }
                })
            } else if let bookDetails = bookDetails {
                BookDetailView(book: bookDetails)
                
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Error"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    func fetchBookDetails(isbn: String) {
        guard !isbn.isEmpty else {
            self.alertMessage = "No barcode scanned."
            self.showAlert = true
            return
        }

        BookAPI.fetchDetails(isbn: isbn) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let details):
                    self.bookDetails = details
                    self.showScanner = false // Close the scanner view
                case .failure(let error):
                    self.alertMessage = self.errorMessage(from: error)
                    self.showAlert = true
                }
            }
        }
    }

    private func errorMessage(from error: APIError) -> String {
        switch error {
        case .invalidResponse:
            return "Failed to fetch book details: Invalid response from server."
        case .networkError(let error):
            return "Failed to fetch book details: Network error \(error.localizedDescription)"
        }
    }
}

struct CContentWiew_Previews: PreviewProvider {
    static var previews: some View {
        ContentWiew()
    }
}
