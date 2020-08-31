// MARK: - NumberInputFormatter: TextInputFormatter

public class NumberInputFormatter: TextInputFormatter {

    // MARK: Properties

    private let numberFormatter = NumberFormatter()
    private var showFractionalDigits: Bool = false

    private var maxNonFractionalValue: Int64 = 0
    public let defaultMaxNonFractionalValue: Int64 = 100000

    private var unformattedNumber: Int64 = 0
    private var unformattedNumberMax: Int64 {
        return showFractionalDigits ? (maxNonFractionalValue * 100) : maxNonFractionalValue
    }

    public static let shared = NumberInputFormatter()

    public var maxDigitsAllowed: UInt {
        return UInt("\(unformattedNumberMax)".count)
    }

    // MARK: Initializer

    private init() {}

    // MARK: TextInputFormatter

    public func applyFormatToTextField(_ textField: UITextField,
                                       shouldChangeCharactersIn range: NSRange,
                                       textToAdd: String) {
        if textToAdd.contains(regex: "[0-9]") || textToAdd.isEmpty {
            textField.text = nextFormattedNumber(currentText: textField.text ?? "", textToAdd: textToAdd)
        }
    }

    public func applyFormatToTextView(_ textView: UITextView,
                                      shouldChangeCharactersIn range: NSRange,
                                      textToAdd: String) {
        if textToAdd.contains(regex: "[0-9]") || textToAdd.isEmpty {
            textView.text = nextFormattedNumber(currentText: textView.text, textToAdd: textToAdd)
        }
    }

    private func nextFormattedNumber(currentText: String, textToAdd: String) -> String {
        if let digitToAdd = Int64(textToAdd) { // adding a digit
            let nextUnformattedNumber = (unformattedNumber * 10) + digitToAdd

            if unformattedNumber < unformattedNumberMax { unformattedNumber = nextUnformattedNumber }

            return getFormattedNumber(currentText: currentText)
        } else if textToAdd == "" { // removing a digit
            let nextUnformattedNumber = unformattedNumber / 10

            if nextUnformattedNumber == 0 {
                unformattedNumber = 0
                return ""
            } else {
                unformattedNumber = nextUnformattedNumber
                return getFormattedNumber(currentText: currentText)
            }
        } else { // unknown
            return ""
        }
    }

    private func getFormattedNumber(currentText: String) -> String {
        if showFractionalDigits { // format w/ fractional digits (ex: 100 ==> $1.00)
            let finalNumber = Double(unformattedNumber / 100) + Double(unformattedNumber % 100) / 100
            return numberFormatter.string(from: NSNumber(value: finalNumber)) ?? currentText
        } else { // format w/o fractional digits (ex: 100 ==> $100)
            let finalNumber = Double(unformattedNumber)
            return numberFormatter.string(from: NSNumber(value: finalNumber)) ?? currentText
        }
    }

    public func formatText(_ unformattedText: String?) -> String? {
        if let unformattedText = unformattedText, let unformattedTextAsDouble = Double(unformattedText) {
            let finalNumber = showFractionalDigits ? (unformattedTextAsDouble / 100.0) : unformattedTextAsDouble
            return numberFormatter.string(from: NSNumber(value: finalNumber))
        } else {
            return unformattedText
        }
    }

    public func unformatText(_ formattedText: String?) -> String? {
        if let formattedText = formattedText,
            let formattedNumber = numberFormatter.number(from: formattedText) {
            return showFractionalDigits ? "\(Int64(round(formattedNumber.doubleValue * 100)))"
                : "\(Int64(formattedNumber.doubleValue))"
        } else {
            return formattedText
        }
    }

    // MARK: Helpers

    public func reset(numberAsString: String,
                      numberStyle: NumberFormatter.Style,
                      maxNonFractionalValue: Int64,
                      showFractionalDigits: Bool) {
        self.maxNonFractionalValue = (maxNonFractionalValue / 10)
        self.showFractionalDigits = showFractionalDigits

        if let stringAsNumber = Int64(numberAsString) {
            self.unformattedNumber = stringAsNumber
        } else {
            self.unformattedNumber = 0
        }

        let fractionalDigits = showFractionalDigits ? 2 : 0
        numberFormatter.currencyCode = "USD"
        numberFormatter.locale = Locale(identifier: "en_US")
        numberFormatter.minimumFractionDigits = fractionalDigits
        numberFormatter.maximumFractionDigits = fractionalDigits
        numberFormatter.numberStyle = numberStyle
    }
}
