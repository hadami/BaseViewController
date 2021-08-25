//
//  UIColor+Component.swift
//  BDM
//
//  Created by rowkaxl on 2021/07/02.
//  Copyright © 2021 Redvelvet Ventures Inc. All rights reserved.
//

import UIKit

public enum Colors: String {
    
    // MARK: Primary
    case primaryBlue
    
    // MARK: Secondary
    case secondaryBlue1
    case secondaryBlue2
    case secondaryBlue3
    case secondaryBlue4
    case secondaryBlue5
    
    case secondaryYellow
    case secondaryPink
    case secondaryOrange
    case secondaryGreen
    case secondaryEmerald
    case secondaryNavy
    
    case secondaryLightYellow
    case secondaryLightPink
    case secondaryLightOrange
    case secondaryLightGreen
    case secondaryLightEmerald
    case secondaryLightNavy
    
    // MARK: GrayscaleColor
    case grayscale07
    case grayscale13
    case grayscale33
    case grayscale44
    case grayscale66
    case grayscale88
    case grayscale99
    case grayscaleBB
    case grayscaleDD
    case grayscaleEE
    case grayscaleF8
    
    // MARK: Text
    case textBlueColor
    case textRed
    case text07
    case text66
    case text99
    case textBB
    
    // MARK: Background
    case bg07
    case bg13
    case bg33
    case bgF8
    case bgDim
    case bgBlue
    case bgPeach
    case bgLightblue
    case bgYellow
}

public extension UIColor {
    
    static var primaryBlue = UIColor(named: Colors.primaryBlue.rawValue) ?? .clear
    
    static var secondaryBlue1 = UIColor(named: Colors.secondaryBlue1.rawValue) ?? .clear
    static var secondaryBlue2 = UIColor(named: Colors.secondaryBlue2.rawValue) ?? .clear
    static var secondaryBlue3 = UIColor(named: Colors.secondaryBlue3.rawValue) ?? .clear
    static var secondaryBlue4 = UIColor(named: Colors.secondaryBlue4.rawValue) ?? .clear
    static var secondaryBlue5 = UIColor(named: Colors.secondaryBlue5.rawValue) ?? .clear
    
    static var secondaryYellow = UIColor(named: Colors.secondaryYellow.rawValue) ?? .clear
    static var secondaryPink = UIColor(named: Colors.secondaryPink.rawValue) ?? .clear
    static var secondaryOrange = UIColor(named: Colors.secondaryOrange.rawValue) ?? .clear
    static var secondaryGreen = UIColor(named: Colors.secondaryGreen.rawValue) ?? .clear
    static var secondaryEmerald = UIColor(named: Colors.secondaryEmerald.rawValue) ?? .clear
    static var secondaryNavy = UIColor(named: Colors.secondaryNavy.rawValue) ?? .clear
    
    static var secondaryLightYellow = UIColor(named: Colors.secondaryLightYellow.rawValue) ?? .clear
    static var secondaryLightPink = UIColor(named: Colors.secondaryLightPink.rawValue) ?? .clear
    static var secondaryLightOrange = UIColor(named: Colors.secondaryLightOrange.rawValue) ?? .clear
    static var secondaryLightGreen = UIColor(named: Colors.secondaryLightGreen.rawValue) ?? .clear
    static var secondaryLightEmerald = UIColor(named: Colors.secondaryLightEmerald.rawValue) ?? .clear
    static var secondaryLightNavy = UIColor(named: Colors.secondaryLightNavy.rawValue) ?? .clear
    
    
    static var grayscale07 = UIColor(named: Colors.grayscale07.rawValue) ?? .clear
    static var grayscale13 = UIColor(named: Colors.grayscale13.rawValue) ?? .clear
    static var grayscale33 = UIColor(named: Colors.grayscale33.rawValue) ?? .clear
    static var grayscale44 = UIColor(named: Colors.grayscale44.rawValue) ?? .clear
    static var grayscale66 = UIColor(named: Colors.grayscale66.rawValue) ?? .clear
    static var grayscale88 = UIColor(named: Colors.grayscale88.rawValue) ?? .clear
    static var grayscale99 = UIColor(named: Colors.grayscale99.rawValue) ?? .clear
    static var grayscaleBB = UIColor(named: Colors.grayscaleBB.rawValue) ?? .clear
    static var grayscaleDD = UIColor(named: Colors.grayscaleDD.rawValue) ?? .clear
    static var grayscaleEE = UIColor(named: Colors.grayscaleEE.rawValue) ?? .clear
    static var grayscaleF8 = UIColor(named: Colors.grayscaleF8.rawValue) ?? .clear
    
    static var textBlueColor = UIColor(named: Colors.textBlueColor.rawValue) ?? .clear
    static var textRed = UIColor(named: Colors.textRed.rawValue) ?? .clear
    static var text07 = UIColor(named: Colors.text07.rawValue) ?? .clear
    static var text66 = UIColor(named: Colors.text66.rawValue) ?? .clear
    static var text99 = UIColor(named: Colors.text99.rawValue) ?? .clear
    static var textBB = UIColor(named: Colors.textBB.rawValue) ?? .clear
    
    static var bg07 = UIColor(named: Colors.bg07.rawValue) ?? .clear
    static var bg13 = UIColor(named: Colors.bg13.rawValue) ?? .clear
    static var bg33 = UIColor(named: Colors.bg33.rawValue) ?? .clear
    static var bgF8 = UIColor(named: Colors.bgF8.rawValue) ?? .clear
    static var bgDim = UIColor(named: Colors.bgDim.rawValue) ?? .clear
    static var bgBlue = UIColor(named: Colors.bgBlue.rawValue) ?? .clear
    static var bgPeach = UIColor(named: Colors.bgPeach.rawValue) ?? .clear
    static var bgLightblue = UIColor(named: Colors.bgLightblue.rawValue) ?? .clear
}
