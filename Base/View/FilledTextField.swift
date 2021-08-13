//
//  FilledTextField.swift
//  Base
//
//  Created by chloe on 2021/08/10.
//

import ReactorKit
import RxCocoa
import RxSwift
import SnapKit
import UIKit
//import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields

class FilledTextFieldReactor: Reactor {
    enum ActionType {
    }
    
    enum Action {
    }
    
    enum Mutation {
    }
    
    struct State {
        let type: TextFieldState
    }
    
    let initialState: State
    
    init(type: TextFieldState) {
        initialState = State(type: type)
    }
}

class FilledTextField: UIView, ReactorKit.View, ConfigurableContainerView {
    typealias DataType = FilledTextFieldReactor
    func configure(data: FilledTextFieldReactor) {
        bind(reactor: data)
    }
    func bind(reactor: FilledTextFieldReactor) {
        setState(state: reactor.currentState.type)
    }
    
    var textField: MDCFilledTextField = {
        let v = MDCFilledTextField()
        v.setFilledBackgroundColor(.clear, for: .normal)
        v.setFilledBackgroundColor(.clear, for: .editing)
        v.setFilledBackgroundColor(.clear, for: .disabled)
        v.label.text = "Phone number"
        v.placeholder = "555-555-5555"
        v.leadingAssistiveLabel.text = "This is helper text"
        v.sizeToFit()
        return v
    }()
    
    var disposeBag = DisposeBag()
    
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
    
    private func setupUI() {
        addSubview(textField)
        
        textField.snp.remakeConstraints {
            $0.edges.equalToSuperview()
//            $0.left.equalToSuperview()
//            $0.right.equalToSuperview().inset(39)
//            $0.top.equalToSuperview().inset(32)
//            $0.bottom.equalToSuperview().inset(30)
        }
    }
    
    private func setupRx() {
    }
    
    private func setState(state: TextFieldState) {
    }

}
