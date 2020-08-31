//
//  SelectionGroupSingleVC.swift
//  Habanero
//
//  Created by Jarrod Parkes on 8/4/20.
//

import Habanero
import UIKit

// MARK: - SelectionGroupSingleVC: UIViewController

class SelectionGroupSingleVC: UIViewController {
    
    // MARK: Properties
    
    let theme = ThemeStandard()
    
    var selectionGroups: [SelectionGroup] = []
    var selectionGroupExamples: [SelectionGroupDisplayable] = []
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Single Selections"
        
        selectionGroupExamples = [
            SelectionGroupExample.mock(theme: theme, tag: 0, numberOfOptions: 3, singleStyle: .menu, selectedIndex: nil),
            SelectionGroupExample.mockWithVariableChoiceLengths(theme: theme, tag: 1),
            SelectionGroupExample.mock(theme: theme, tag: 2, numberOfOptions: 10, singleStyle: .topChoices(false, SELECTION_GROUP_EXPAND_TITLE), selectedIndex: nil)
        ]
        
        let colors = theme.colors
        view.backgroundColor = colors.backgroundCell
        
        let scrollView = UIScrollView(frame: CGRect(x: 0,
                                                    y: 80,
                                                    width: view.bounds.width,
                                                    height: view.bounds.height))
        scrollView.alwaysBounceHorizontal = false
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 100, right: 16)
        
        let stackView = UIStackView(frame: .zero)
        stackView.spacing = 16
        stackView.axis = .vertical
        
        stackView.addArrangedSubview(createLabel(text: "Style: Menu"))
        let selectionGroup0 = SelectionGroup(frame: .zero)
        selectionGroup0.presentingVC = self
        selectionGroup0.delegate = self
        selectionGroup0.styleWith(theme: theme, displayable: selectionGroupExamples[0])
        stackView.addArrangedSubview(selectionGroup0)
        
        stackView.addArrangedSubview(createLabel(text: "Style: All Choices"))
        let selectionGroup1 = SelectionGroup(frame: .zero)
        selectionGroup1.delegate = self
        selectionGroup1.styleWith(theme: theme, displayable: selectionGroupExamples[1])
        stackView.addArrangedSubview(selectionGroup1)
        
        stackView.addArrangedSubview(createLabel(text: "Style: Top Choices"))
        let selectionGroup2 = SelectionGroup(frame: .zero)        
        selectionGroup2.delegate = self
        selectionGroup2.styleWith(theme: theme, displayable: selectionGroupExamples[2])
        stackView.addArrangedSubview(selectionGroup2)
        
        stackView.addArrangedSubview(UIView())
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9)
            ])

        selectionGroups = [
            selectionGroup0,
            selectionGroup1,
            selectionGroup2
        ]
    }
    
    // MARK: Helpers
    
    func createLabel(text: String) -> UILabel {
        let label = UILabel(frame: .zero)
        label.attributedText = text.attributed(fontStyle: .labelLarge, color: theme.colors.textHighEmphasis)
        return label
    }
}

// MARK: - SelectionGroupSingleVC: SelectionGroupDelegate

extension SelectionGroupSingleVC: SelectionGroupDelegate {
    func selectionGroupSelectionChanged(_ selectionGroup: SelectionGroup, selection: Selection) {
        updateSelectionGroup(selectionGroup, selection: selection)
    }
    
    func selectionGroupShouldExpand(_ selectionGroup: SelectionGroup) {
        if let currentExample = selectionGroupExamples[selectionGroup.tag] as? SelectionGroupExample {
            let newExample = SelectionGroupExample(controls: currentExample.controls,
                                                   tag: currentExample.tag,
                                                   style: .single(.topChoices(true, SELECTION_GROUP_EXPAND_TITLE)),
                                                   selection: currentExample.selection)
            selectionGroupExamples[selectionGroup.tag] = newExample
            
            selectionGroups[selectionGroup.tag].styleWith(theme: theme,
                                                          displayable: selectionGroupExamples[selectionGroup.tag])
        }        
    }
    
    func selectionGroupTipWasTapped(_ selectionGroup: SelectionGroup, selectionControl: SelectionControl) {
        let alert = Alert(type: .error, message: "A tip was tapped.", duration: 2.0, anchor: .bottom)
        AlertManager.shared.show(alert, onView: view, withTheme: theme)
    }
    
    private func updateSelectionGroup(_ selectionGroup: SelectionGroup, selection: Selection) {
        selectionGroupExamples[selectionGroup.tag].selection = selection
        selectionGroups[selectionGroup.tag].styleWith(theme: theme,
                                                      displayable: selectionGroupExamples[selectionGroup.tag])
    }
}
