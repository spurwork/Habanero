// MARK: - Calendar (Helpers)

extension Calendar {
    func trimTimeFromDate(_ fromDate: Date) -> Date? {
        let components = dateComponents([.year, .month, .day], from: fromDate)
        return date(from: components)
    }

    func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []

        var date = fromDate
        while date <= toDate {
            dates.append(date)
            guard let newDate = self.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }

        return dates
    }
}
