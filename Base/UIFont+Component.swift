//
//  UIFont+Component.swift
//  BDM
//
//  Created by rowkaxl on 2021/07/05.
//  Copyright © 2021 Redvelvet Ventures Inc. All rights reserved.
//

import Foundation
import UIKit

public enum ComponentFont {
    
    public static func font(weight: Weights,
              size: Sizes) -> UIFont {
        switch weight {
        case .regular:
            return UIFont.systemFont(ofSize: size.rawValue)
        case .bold:
            return UIFont.boldSystemFont(ofSize: size.rawValue)
        }
    }
    
    public enum Weights {
        case bold
        case regular
    }
    
    public enum Sizes: CGFloat {
        case px32 = 32.0
        case px26 = 26.0
        case px22 = 22.0
        case px18 = 18.0
        case px16 = 16.0
        case px14 = 14.0
        case px12 = 12.0
        case px10 = 10.0
    }
    
    enum LineHeights: CGFloat {
        case px38 = 38.0
        case px32 = 32.0
        case px28 = 28.0
        case px24 = 24.0
        case px22 = 22.0
        case px20 = 20.0
        case px18 = 18.0
        case px14 = 14.0
    }
    
    enum LetterSpacings: CGFloat {
        case positive = 1
        case negative = -1
        
        enum Number: CGFloat {
            case zero = 0
            case one = 1
        }
        
        enum Decimal: CGFloat {
            case zero = 0
            case five = 0.5
        }
        
        func number(_ number: Number = .zero,
                    decimal: Decimal = .zero) -> CGFloat {
            return self.rawValue * (number.rawValue + decimal.rawValue)
        }
    }
}

extension ComponentFont.Sizes {
    
    var lineHeight: CGFloat {
        switch self {
        case .px32:
            return ComponentFont.LineHeights.px38.rawValue
        case .px26:
            return ComponentFont.LineHeights.px32.rawValue
        case .px22:
            return ComponentFont.LineHeights.px28.rawValue
        case .px18:
            return ComponentFont.LineHeights.px24.rawValue
        case .px16:
            return ComponentFont.LineHeights.px22.rawValue
        case .px14:
            return ComponentFont.LineHeights.px20.rawValue
        case .px12:
            return ComponentFont.LineHeights.px18.rawValue
        case .px10:
            return ComponentFont.LineHeights.px14.rawValue
        }
    }
    
    var letterSpacing: CGFloat {
        switch self {
        case .px32:
            return ComponentFont.LetterSpacings.negative.number(.one)
        case .px26:
            return ComponentFont.LetterSpacings.negative.number(.one)
        case .px22:
            return ComponentFont.LetterSpacings.negative.number(.one)
        case .px18:
            return ComponentFont.LetterSpacings.negative.number(.zero, decimal: .five)
        case .px16:
            return ComponentFont.LetterSpacings.negative.number(.zero, decimal: .five)
        case .px14:
            return ComponentFont.LetterSpacings.negative.number(.zero, decimal: .five)
        case .px12:
            return ComponentFont.LetterSpacings.negative.number(.zero, decimal: .five)
        case .px10:
            return ComponentFont.LetterSpacings.negative.number(.zero, decimal: .five)
        }
    }
}

public extension String {
    
    func toAttributeString(weight: ComponentFont.Weights,
                     size: ComponentFont.Sizes,
                     color: UIColor,
                     underLine: Bool = false,
                     alignment: NSTextAlignment = .left,
                     lineBreakMode: NSLineBreakMode = .byWordWrapping) -> NSMutableAttributedString {
        

        let s = NSMutableAttributedString(string: self)
        let style = NSMutableParagraphStyle()

        let range = NSRange(location: 0, length: self.count)
        style.maximumLineHeight = size.lineHeight
        style.minimumLineHeight = size.lineHeight
        style.alignment = alignment
        style.lineBreakMode = lineBreakMode

        s.addAttribute(.font, value: ComponentFont.font(weight: weight, size: size), range: range)
        s.addAttribute(.kern, value: size.letterSpacing, range: range)
        s.addAttribute(.paragraphStyle, value: style, range: range)
        s.addAttribute(.foregroundColor, value: color, range: range)

        if underLine {
            s.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        }

        return s
    }
}
