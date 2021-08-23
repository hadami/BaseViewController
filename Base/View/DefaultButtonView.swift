//
//  DefaultButtonView.swift
//  Base
//
//  Created by chloe on 2021/08/09.
//

import ReactorKit
import RxCocoa
import RxSwift
import SnapKit
import UIKit

enum BaseButtonStyle: Equatable {
    case bottomFixed(title: String = "확인", state: State)
    case scrollable(title: String = "확인", state: State, type: Height)
    
    enum Height: Int {
        case H52 = 52
        case H40 = 40
    }
    
    enum State: Equatable {
        case primary
        case secondary(color: Color)
        case disabled
        
        enum Color {
            case blue
            case gray
            
            var color: UIColor {
                let color: UIColor
                switch self {
                case .blue:
                    color = .blue
                case .gray:
                    color = .gray
                }
                return color
            }
        }
    }
    
    var height: Int {
        get {
            switch self {
            case .bottomFixed(_, _):
                return 60
            case .scrollable(_, _, let h):
                return h.rawValue
            }
        }
    }
}

class BaseButtonReactor: Reactor {
    enum ActionType {
    }
    
    enum Action {
    }
    
    enum Mutation {
    }
    
    struct State {
        let type: BaseButtonStyle
        let insets: UIEdgeInsets
    }
    
    let initialState: State
    
    init(type: BaseButtonStyle,
         insets: UIEdgeInsets? = nil) {
        initialState = State(type: type,
                             insets: insets ?? .init(top: 0, left: 20, bottom: 0, right: 20))
    }
}

class BaseButton: GenericContainerView<BaseButtonReactor> {
    
    fileprivate var confirmButton: UIButton = {
        let v = UIButton.init(type: .system)
        v.layer.cornerRadius = 8
        return v
    }()
    
    convenience init() {
        self.init(frame: .zero)
        setupUI()
        setupRx()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupRx()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("deinit - \(String(describing: type(of: self)))")
    }
    
    override func bind(reactor: Reactor) {
        var insets = reactor.currentState.insets
        let type = reactor.currentState.type
        
        var height = 0
        let style: BaseButtonStyle.State
        
        switch type {
        case .bottomFixed(let title, let state):
            var bottomInset: CGFloat = 24
            let window = UIApplication.shared.keyWindow
            if let bottomPadding = window?.safeAreaInsets.bottom, bottomPadding > 0 {
                bottomInset = 8
            }
            insets.bottom = bottomInset
            height = 60
            style = state
            confirmButton.setTitle(title, for: .normal)
        case .scrollable(let title, let state, let h):
            height = h.rawValue
            style = state
            confirmButton.setTitle(title, for: .normal)
        }
        
        switch style {
        case .primary:
            confirmButton.backgroundColor = .blue
            confirmButton.setTitleColor(.white, for: .normal)
        case .secondary(let colorType):
            confirmButton.backgroundColor = .white
            confirmButton.layer.borderWidth = 1
            confirmButton.layer.borderColor = colorType.color.cgColor
            confirmButton.setTitleColor(colorType.color, for: .normal)
        case .disabled:
            confirmButton.backgroundColor = .gray
            confirmButton.setTitleColor(.darkGray, for: .normal)
        }
        
        confirmButton.snp.remakeConstraints {
            $0.height.equalTo(height).priority(.high)
            $0.edges.equalToSuperview().inset(insets)
        }
        confirmButton.isHidden = false
    }
    
    private func setupUI() {
        addSubview(confirmButton)
        confirmButton.isHidden = true
    }
    
    private func setupRx() {
    }

}

extension Reactive where Base: BaseButton {
    var buttonTap: ControlEvent<Void> {
        let source: Observable<Void> = self.base.confirmButton.rx.tap.asObservable()
      return ControlEvent(events: source)
    }
}
