//
//  ColorCell.swift
//  Habanero
//
//  Created by Jarrod Parkes on 5/11/20.
//

import Habanero
import UIKit

// MARK: - ColorCellDisplayable

protocol ColorCellDisplayable {
    var backgroundColor: UIColor? { get }
    var titleColor: UIColor { get }
    var title: String { get }
    var subtitle: String { get }
}

// MARK: - ColorCell: BaseTableViewCell

class ColorCell: BaseTableViewCell {

    // MARK: Initializer

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    // MARK: Style

    override func styleWith(theme: Theme) {
        super.styleWith(theme: theme)

        selectionStyle = .none

        let colors = theme.colors

        imageView?.tintColor = colors.textHighEmphasis
        textLabel?.numberOfLines = 0
        detailTextLabel?.numberOfLines = 0
    }

    func styleWith(theme: Theme, displayable: ColorCellDisplayable) {
        backgroundColor = displayable.backgroundColor        
        textLabel?.attributedText = displayable.title.attributed(fontStyle: .labelLarge, color: displayable.titleColor)
        detailTextLabel?.attributedText = displayable.subtitle.attributed(fontStyle: .bodySmall, color: displayable.titleColor)
    }
}
