//
//  NotesVC.swift
//  Habanero
//
//  Created by Jarrod Parkes on 9/8/20.
//

import Habanero
import UIKit

// MARK: - NotesVC: UIViewController

class NotesVC: UIViewController {
    
    // MARK: Properties
    
    let theme: Theme
                
    // MARK: Initializer
    
    init(theme: Theme) {
        self.theme = theme
        super.init(nibName: nil, bundle: nil)
        title = "Notes"
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = theme.colors.backgroundCell
        
        let note = Note(config: .link("https://spurwork.com"), text: "Contact Support")
        let notesView = NotesView(frame: CGRect(x: 20, y: 100, width: view.frame.width - 40, height: 76))
        notesView.delegate = self
        notesView.styleWith(theme: theme, displayable: Notes(notes: [note]))
        
        view.addSubview(notesView)
    }
}

// MARK: - NotesVC: NotesViewDelegate

extension NotesVC: NotesViewDelegate {
    func notesViewTappedNote(_ notesView: NotesView, backedValue: Any?) {
        let alert = Alert(type: .info, message: "Label tapped: \(backedValue ?? "nil")", duration: 2.0, anchor: .bottom)
        AlertManager.shared.show(alert, onView: view, withTheme: theme)
    }
}
