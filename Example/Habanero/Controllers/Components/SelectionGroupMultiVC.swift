//
//  SelectionGroupMultiVC.swift
//  Habanero
//
//  Created by Jarrod Parkes on 8/4/20.
//

import Habanero
import UIKit

// MARK: - SelectionGroupMultiVC: UIViewController

class SelectionGroupMultiVC: UIViewController {
    
    // MARK: Properties
                
    let theme = ThemeStandard()
    
    var selectionGroups: [SelectionGroup] = []
    var selectionGroupExamples: [SelectionGroupDisplayable] = []
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectionGroupExamples = [
            SelectionGroupExample.mock(theme: theme, tag: 0, numberOfOptions: 2, selectedIndices: [])
        ]
        
        let colors = theme.colors
        view.backgroundColor = colors.backgroundCell

        let xOffset: CGFloat = 20
        let stackView = UIStackView(frame: CGRect(x: xOffset,
                                                  y: 80,
                                                  width: view.bounds.width - 40,
                                                  height: view.bounds.height - 100))
        stackView.spacing = 16
        stackView.axis = .vertical
        
        let selectionGroup0 = SelectionGroup(frame: .zero)
        selectionGroup0.delegate = self
        selectionGroup0.styleWith(theme: theme, displayable: selectionGroupExamples[0])
        stackView.addArrangedSubview(selectionGroup0)
        
        stackView.addArrangedSubview(UIView())
        view.addSubview(stackView)
        
        selectionGroups = [
            selectionGroup0
        ]
    }
}

// MARK: - SelectionGroupMultiVC: SelectionGroupDelegate

extension SelectionGroupMultiVC: SelectionGroupDelegate {
    func selectionGroupSelectionChanged(_ selectionGroup: SelectionGroup, selection: Selection) {
        selectionGroupExamples[selectionGroup.tag].selection = selection
        selectionGroups[selectionGroup.tag].styleWith(theme: theme,
                                                      displayable: selectionGroupExamples[selectionGroup.tag])
    }
    
    func selectionGroupTipWasTapped(_ selectionGroup: SelectionGroup, selectionControl: SelectionControl) {
        let alert = Alert(type: .error, message: "A tip was tapped.", duration: 2.0, anchor: .bottom)
        AlertManager.shared.show(alert, onView: view, withTheme: theme)
    }
    
    func selectionGroupShouldExpand(_ selectionGroup: SelectionGroup) {}    
}
