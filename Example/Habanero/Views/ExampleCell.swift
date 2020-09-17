//
//  ExampleCell.swift
//  Habanero
//
//  Created by Jarrod Parkes on 7/29/20.
//

import Habanero
import UIKit

// MARK: - ExampleCell: BaseTableViewCell

class ExampleCell: BaseTableViewCell {

    // MARK: Properties
    
    private let stackView = UIStackView(frame: .zero)
    private let titleLabel = UILabel(frame: .zero)
        
    private var titleHeight: NSLayoutConstraint?
    
    override var visualConstraintViews: [String: AnyObject] {
        return [
            "stackView": stackView
        ]
    }

    override var visualConstraints: [String] {
        return [
            "H:|-16-[stackView]-16-|",
            "V:|-16-[stackView]-16-|"
        ]
    }
    
    // MARK: Initializer

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.contentView.isUserInteractionEnabled = false
    }
    
    override func addSubviews() {
        addSubview(stackView)
    }

    // MARK: Style

    func styleWith(theme: Theme, title: String, contentView: UIView) {
        isUserInteractionEnabled = true
        stackView.removeAllArrangedSubviews(deactivateConstraints: false)
        
        stackView.axis = .vertical                
        stackView.spacing = 12
        
        if titleHeight == nil {
            titleHeight = titleLabel.heightAnchor.constraint(equalToConstant: 24)
            if let titleHeight = titleHeight {
                NSLayoutConstraint.activate([titleHeight])
            }
        }
        
        titleLabel.attributedText = "\(title)".attributed(fontStyle: .labelLarge,
                                                          color: theme.colors.textHighEmphasis)
                                
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(contentView)
    }
}
