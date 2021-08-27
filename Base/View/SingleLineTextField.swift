//
//  SingleLineTextField.swift
//  Base
//
//  Created by chloe on 2021/08/04.
//

import ReactorKit
import RxCocoa
import RxSwift
import SnapKit
import UIKit

enum TextFieldState: Equatable {
    case editing
    case error(title: String)
    case done
    case disabled
}

class SingleLineTextFieldReactor: Reactor {
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

class SingleLineTextField: GenericContainerView<SingleLineTextFieldReactor> {
    override func bind(reactor: Reactor) {
        setState(state: reactor.currentState.type)
    }
    
    let borderWidth: CGFloat = 1
    let highlightedBorderWidth: CGFloat = 2
    let normalBorderColor: UIColor = .grayscaleDD
    let highlightedBorderColor: UIColor = .textBlueColor
    let errorColor: UIColor = .textRed
    let normalTextColor: UIColor = .text66
    let highlightedTextColor: UIColor = .text07
    let disabledTextColor: UIColor = .textBB
    
    let textFieldFont: UIFont = ComponentFont.font(weight: .regular, size: .px18)
    let errorFont: UIFont = ComponentFont.font(weight: .regular, size: .px12)
    
    var textField: UITextField = {
        let v = UITextField()
//        v.font = ComponentFont.font(weight: .regular, size: .px18)
//        v.tintColor = .black
        v.textColor = .text07
        
        v.borderStyle = .none
        return v
    }()
    
    fileprivate var clearButton: UIButton = {
        let v = UIButton.init(type: .system)
        v.setImage(#imageLiteral(resourceName: "eraseAll"), for: .normal)
        return v
    }()
    
    fileprivate var placeholderLabel: UILabel = {
        let v = UILabel()
        v.text = "라벨"
//        v.font = ComponentFont.font(weight: .regular, size: .px18)
//        v.textColor = .text66
        return v
    }()
    
    fileprivate var errorLabel: UILabel = {
        let v = UILabel()
        return v
    }()
    
    fileprivate var borderView: UIView = {
        let v = UIView()
//        v.backgroundColor = .lightGray
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
    
    private func setupUI() {
        textField.font = textFieldFont
        placeholderLabel.font = textFieldFont
        errorLabel.font = errorFont
        
        addSubview(textField)
        addSubview(clearButton)
        addSubview(placeholderLabel)
        addSubview(errorLabel)
        addSubview(borderView)
        
        placeholderLabel.snp.remakeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.left.equalToSuperview()
            $0.height.equalTo(18)
        }
        
        // TODO: clearButton 처리
        textField.snp.remakeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalToSuperview().inset(39)
            $0.top.equalToSuperview().inset(32)
            $0.bottom.equalToSuperview().inset(30)
        }
        
        clearButton.snp.remakeConstraints {
            $0.right.equalToSuperview()
            $0.centerY.equalToSuperview().offset(2)
        }
        
        borderView.snp.remakeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
            $0.height.equalTo(1)
        }
        
        errorLabel.snp.remakeConstraints {
            $0.left.bottom.equalToSuperview()
//            $0.height.equalTo(18)
        }
    }
    
    private func setupRx() {
        clearButton.rx.tap.subscribe({ [weak self] _ in
            guard let self = self else { return }
            self.textField.text = ""
        }).disposed(by: disposeBag)
        
        textField.rx.controlEvent([.editingDidBegin]).subscribe({ [weak self] _ in
            guard let self = self else { return }
            self.setState(state: .editing)
        }).disposed(by: disposeBag)
        
        textField.rx.controlEvent([.editingDidEnd, .editingDidEndOnExit]).subscribe({ [weak self] _ in
            guard let self = self else { return }
            self.setState(state: .done)
        }).disposed(by: disposeBag)
    }
    
    private func setState(state: TextFieldState) {
        var isError = false
        
        switch state {
        case .editing:
            placeholderLabel.textColor = normalTextColor
            borderView.backgroundColor = highlightedBorderColor
        case .error(let title):
            let color = errorColor
            placeholderLabel.textColor = color
            borderView.backgroundColor = color
            errorLabel.textColor = color
            errorLabel.text = title
            isError = true
        case .done:
            placeholderLabel.textColor = normalTextColor
            borderView.backgroundColor = borderColor
        case .disabled:
            let color = disabledTextColor
            placeholderLabel.textColor = color
            textField.textColor = color
            borderView.backgroundColor = borderColor
        }
        errorLabel.isHidden = !isError
        clearButton.isHidden = state != .editing
        textField.isEnabled = state != .disabled
        
        UIView.animate(withDuration: 10) { [weak self] in
            guard let self = self else { return }
            self.layoutIfNeeded()
        }
    }

}

extension Reactive where Base: SingleLineTextField {
    var textFieldChanged: ControlEvent<UITextField> {
        let source: Observable<UITextField> = self.base.textField.rx.controlEvent([.editingChanged]).asObservable()
            .flatMap { Observable.just(self.base.textField) }
      return ControlEvent(events: source)
    }
    
    var textFieldFocusIn: ControlEvent<UITextField> {
        let source: Observable<UITextField> = self.base.textField.rx.controlEvent([.editingDidBegin]).asObservable()
            .flatMap { Observable.just(self.base.textField) }
        return ControlEvent(events: source)
    }
    
    var textFieldFocusOut: ControlEvent<UITextField> {
        let source: Observable<UITextField> = self.base.textField.rx.controlEvent([.editingDidEnd, .editingDidEndOnExit]).asObservable()
            .flatMap { Observable.just(self.base.textField) }
        return ControlEvent(events: source)
    }
}
