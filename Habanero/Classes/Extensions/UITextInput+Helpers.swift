// MARK: - UITextInput (Helpers)

extension UITextInput {
    func adjustCursorForOriginalRange(_ range: NSRange, replacementText text: String) {
        DispatchQueue.main.async {
            let offset = text.isEmpty ? range.location : range.location + 1
            if let newPosition = self.position(from: self.beginningOfDocument, offset: offset) {
                self.selectedTextRange = self.textRange(from: newPosition, to: newPosition)
            }
        }
    }
}
