//
//  ButtonStackView.swift
//  Base
//
//  Created by chloe on 2021/08/23.
//

import ReactorKit
import RxCocoa
import RxSwift
import SnapKit
import UIKit

class ButtonStackViewReactor: Reactor {
    enum ActionType {
    }
    
    enum Action {
    }
    
    enum Mutation {
    }
    
    struct State {
        let leftType: BaseButtonStyle
        let rightType: BaseButtonStyle
        let insets: UIEdgeInsets
    }
    
    let initialState: State
    
    init(leftType: BaseButtonStyle,
         rightType: BaseButtonStyle,
         insets: UIEdgeInsets? = nil) {
        initialState = State(leftType: leftType,
                             rightType: rightType,
                             insets: insets ?? .init(top: 0, left: 20, bottom: 0, right: 20))
    }
}

class ButtonStackView: GenericContainerView<ButtonStackViewReactor> {
    fileprivate var rightButton: BaseButton = {
        let v = BaseButton.init()
        return v
    }()
    
    fileprivate var leftButton: BaseButton = {
        let v = BaseButton.init()
        return v
    }()
    
    fileprivate var stackView: UIStackView = {
        let v = UIStackView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .horizontal
        v.distribution = .fillEqually
        v.spacing = 8
        return v
    }()
    
    private var isHiddenButtons: Bool = true {
        didSet {
            leftButton.isHidden = isHiddenButtons
            rightButton.isHidden = isHiddenButtons
        }
    }
    
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
        // FIXME:
        isHiddenButtons = false
        
        let leftType = reactor.currentState.leftType
        let rightType = reactor.currentState.rightType
        let insets = reactor.currentState.insets
        leftButton.reactor = .init(type: leftType,
                                     insets: .zero)
        rightButton.reactor = .init(type: rightType,
                                     insets: .zero)
        
        stackView.snp.remakeConstraints {
            $0.height.equalTo(rightType.height).priority(.high)
            $0.edges.equalToSuperview().inset(insets)
        }
    }
    
    private func setupUI() {
        addSubview(stackView)
        stackView.addArrangedSubview(leftButton)
        stackView.addArrangedSubview(rightButton)
    }
    
    private func setupRx() {
    }
}

extension Reactive where Base: ButtonStackView {
    var rightButtonTap: ControlEvent<Void> {
        let source: Observable<Void> = self.base.rightButton.rx.buttonTap.asObservable()
      return ControlEvent(events: source)
    }
    var leftButtonTap: ControlEvent<Void> {
        let source: Observable<Void> = self.base.leftButton.rx.buttonTap.asObservable()
      return ControlEvent(events: source)
    }
}
