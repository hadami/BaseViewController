//
//  Vibrate.swift
//  Base
//
//  Created by chloe on 2021/08/30.
//

import AudioToolbox
import AVFoundation
import SnapKit
import UIKit

enum Vibration {
    case error
    case success
    case warning
    case light
    case medium
    case heavy
    @available(iOS 13.0, *)
    case soft
    @available(iOS 13.0, *)
    case rigid
    case selection
    case oldSchool
    
    public func vibrate() {
        switch self {
        case .error:
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        case .success:
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        case .warning:
            UINotificationFeedbackGenerator().notificationOccurred(.warning)
        case .light:
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        case .medium:
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        case .heavy:
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        case .soft:
            if #available(iOS 13.0, *) {
                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
            }
        case .rigid:
            if #available(iOS 13.0, *) {
                UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
            }
        case .selection:
            UISelectionFeedbackGenerator().selectionChanged()
        case .oldSchool:
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
}

extension Constraint {
    /// 에러 메세지 SpringDamping Animation
    func errorAnimation(_ view: UIView, from: CGFloat, to: CGFloat, handler: @escaping () -> Void = {}) {
        self.update(offset: from)
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: 0.15,
                       initialSpringVelocity: 10.0,
                       options: [],
                       animations: {
                        self.update(offset: to)
                        view.layoutIfNeeded()
                       },
                       completion: { _ in
                        handler()
                       })
    }
}
