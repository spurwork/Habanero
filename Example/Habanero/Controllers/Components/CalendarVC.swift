//
//  CalendarVC.swift
//  Habanero
//
//  Created by Jarrod Parkes on 8/25/20.
//

import Habanero
import UIKit

// MARK: - CalendarVC: UIViewController

class CalendarVC: UIViewController {
    
    // MARK: Properties
    
    let theme: Theme
    let config: HCalendarViewConfig
    let datesToStatus: [Date: [CalendarDayStatus]]
    let highlightedDates: [Date]
            
    var calendarView: HCalendarView!
        
    // MARK: Initializer
    
    init(theme: Theme, config: HCalendarViewConfig, datesToStatus: [Date: [CalendarDayStatus]], highlightedDates: [Date] = []) {
        self.theme = theme
        self.config = config
        self.datesToStatus = datesToStatus
        self.highlightedDates = highlightedDates
        
        super.init(nibName: nil, bundle: nil)
        
        title = "Calendar"
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = theme.colors.backgroundCell
                        
        calendarView = HCalendarView(theme: theme,
                                    width: view.bounds.width - 16,
                                    config: config)
        calendarView.delegate = self
        calendarView.styleWith(theme: theme, datesToStatus: datesToStatus, highlightedDates: highlightedDates)
        
        view.addSubview(calendarView)
                
        calendarView.translatesAutoresizingMaskIntoConstraints = false        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 24),
            calendarView.heightAnchor.constraint(equalToConstant: 290),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

// MARK: - CalendarVC: HCalendarViewDelegate

extension CalendarVC: HCalendarViewDelegate {
    func calendarViewTriedOverscroll(_ calendarView: HCalendarView) {
        let message = "Can't overscroll"
        let alert = Alert(type: .error, message: message, duration: 2.0, anchor: .bottom)
        AlertManager.shared.show(alert, onView: view, withTheme: theme)
    }
    
    func calendarViewSelectionDidChange(_ calendarView: HCalendarView,
                                        selection: CalendarDaySelection,
                                        selectedDates: [Date]) {}
}
