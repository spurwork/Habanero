//
//  Color.swift
//  Habanero
//
//  Created by Jarrod Parkes on 5/10/20.
//

import Habanero
import UIKit

// MARK: - Color

struct Color {

    // MARK: Properties

    let category: ColorCategory
    let name: String
    let color: UIColor
    let textColor: UIColor

    var hex: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        color.getRed(&r, green: &g, blue: &b, alpha: &a)

        let rgb: Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0

        return String(format: "#%06x", rgb)
    }
}

// MARK: - Color: ColorCellDisplayable

extension Color: ColorCellDisplayable {
    var backgroundColor: UIColor? { return color }
    var titleColor: UIColor { return textColor }
    var title: String { return "\(category.rawValue) / \(name)" }
    var subtitle: String { return hex }
}
