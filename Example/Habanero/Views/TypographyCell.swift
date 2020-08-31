//
//  TypographyCell.swift
//  Habanero
//
//  Created by Jarrod Parkes on 5/11/20.
//

import Habanero
import UIKit

// MARK: - TypographyCellDisplayable

protocol TypographyCellDisplayable {
    var fontStyle: FontStyle { get }
    var title: String { get }
    var subtitle: String { get }
}

// MARK: - TypographyCell: BaseTableViewCell

class TypographyCell: BaseTableViewCell {

    // MARK: Initializer

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    // MARK: Style

    override func styleWith(theme: Theme) {
        super.styleWith(theme: theme)

        selectionStyle = .none
        
        textLabel?.numberOfLines = 0
        detailTextLabel?.numberOfLines = 0
    }

    func styleWith(theme: Theme, displayable: TypographyCellDisplayable) {
        let colors = theme.colors
        let textColor = colors.textHighEmphasis
        
        textLabel?.attributedText = displayable.title.attributed(fontStyle: displayable.fontStyle, color: textColor)
        detailTextLabel?.attributedText = displayable.subtitle.attributed(fontStyle: .bodyLarge, color: textColor)
    }
}
