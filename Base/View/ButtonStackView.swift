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
        let type: (BaseButtonStyle, BaseButtonStyle)
        let insets: UIEdgeInsets
    }
    
    let initialState: State
    
    init(type: (BaseButtonStyle, BaseButtonStyle),
         insets: UIEdgeInsets? = nil) {
        initialState = State(type: type,
                             insets: insets ?? .init(top: 0, left: 20, bottom: 0, right: 20))
    }
}

class ButtonStackView: GenericContainerView<ButtonStackViewReactor> {
    fileprivate var confirmButton: BaseButton = {
        let v = BaseButton.init()
        return v
    }()
    
    fileprivate var cancelButton: BaseButton = {
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
        let type = reactor.currentState.type
        let insets = reactor.currentState.insets
        cancelButton.reactor = .init(type: type.0,
                                     insets: .zero)
        confirmButton.reactor = .init(type: type.1,
                                     insets: .zero)
        cancelButton.isHidden = false
        confirmButton.isHidden = false
        
        stackView.snp.remakeConstraints {
            $0.height.equalTo(type.0.height).priority(.high)
            $0.edges.equalToSuperview().inset(insets)
        }
    }
    
    private func setupUI() {
        addSubview(stackView)
        stackView.addArrangedSubview(cancelButton)
        stackView.addArrangedSubview(confirmButton)
        cancelButton.isHidden = true
        confirmButton.isHidden = true
    }
    
    private func setupRx() {
    }
}

extension Reactive where Base: ButtonStackView {
    var confirmButtonTap: ControlEvent<Void> {
        let source: Observable<Void> = self.base.confirmButton.rx.buttonTap.asObservable()
      return ControlEvent(events: source)
    }
    var cancelButtonTap: ControlEvent<Void> {
        let source: Observable<Void> = self.base.cancelButton.rx.buttonTap.asObservable()
      return ControlEvent(events: source)
    }
}
