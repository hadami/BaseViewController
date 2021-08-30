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
        var type: TextFieldState
    }
    
    let initialState: State
    
    init(type: TextFieldState = .done) {
        initialState = State(type: type)
    }
}

class SingleLineTextField: GenericContainerView<SingleLineTextFieldReactor> {
    fileprivate let borderWidth: CGFloat = 1
    fileprivate let highlightedBorderWidth: CGFloat = 2
    fileprivate let normalBorderColor: UIColor = .grayscaleDD
    fileprivate let highlightedBorderColor: UIColor = .textBlue
    fileprivate let errorColor: UIColor = .textRed
    fileprivate let normalTextColor: UIColor = .text66
    fileprivate let highlightedTextColor: UIColor = .text07
    fileprivate let disabledTextColor: UIColor = .textBB
    
    fileprivate let textFieldFont: UIFont = ComponentFont.font(weight: .regular, size: .px18)
    fileprivate let errorFont: UIFont = ComponentFont.font(weight: .regular, size: .px12)
    
    fileprivate var placeholderLeftConstraint: Constraint?
    
    var textField: UITextField = {
        let v = UITextField()
        v.borderStyle = .none
        return v
    }()
    
    fileprivate var clearButton: UIButton = {
        let v = UIButton.init(type: .custom)
        v.setImage(#imageLiteral(resourceName: "eraseAll"), for: .normal)
        return v
    }()
    
    fileprivate var placeholderLabel: UILabel = {
        let v = UILabel()
        v.text = "라벨"
        return v
    }()
    
    fileprivate var errorLabel: UILabel = {
        let v = UILabel()
        v.text = "error"
        return v
    }()
    
    fileprivate var borderView: UIView = {
        let v = UIView()
        return v
    }()
    
    convenience init() {
        self.init(frame: .zero)
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
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
        
        textField.tintColor = highlightedTextColor
        
        addSubview(textField)
        addSubview(clearButton)
        addSubview(placeholderLabel)
        addSubview(errorLabel)
        addSubview(borderView)
        
        placeholderLabel.snp.remakeConstraints {
            placeholderLeftConstraint = $0.left.equalToSuperview().constraint
            $0.top.equalToSuperview().inset(26)
            $0.right.lessThanOrEqualToSuperview()
            $0.height.equalTo(24)
        }
        
        textField.snp.remakeConstraints {
            let insets = UIEdgeInsets(top: 32, left: 0, bottom: 30, right: 39)
            $0.edges.equalToSuperview().inset(insets)
        }
        
        clearButton.snp.remakeConstraints {
            $0.right.equalToSuperview()
            $0.centerY.equalTo(textField.snp.centerY)
        }

        errorLabel.snp.remakeConstraints {
            $0.left.bottom.equalToSuperview()
        }
        
        self.snp.remakeConstraints {
            $0.height.equalTo(86)
        }
        
        updateStyle(with: .done)
    }
    
    override func bind(reactor: Reactor) {
        setupRx()
        setState(state: .done)
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
        
        textField.rx.textChanged.subscribe(onNext: { [weak self] text in
            guard let self = self else { return }
            self.setState(state: .editing)
            
            // TODO: resign 호출되면 호출됨... 확인하고.... clearButton 숨김 조건 다시 확인
            let isHidden = text?.isEmpty ?? true
            if isHidden != self.clearButton.isHidden {
                self.clearButton.isHidden = false
                self.clearButton.alpha = isHidden ? 1 : 0
                
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: { [weak self] in
                    guard let self = self else { return }
                    self.clearButton.alpha = isHidden ? 0 : 1
                    self.clearButton.layoutIfNeeded()
                }, completion: { [weak self] _ in
                    guard let self = self else { return }
                    self.clearButton.isHidden = isHidden
                })
            }
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
            borderView.backgroundColor = normalBorderColor
        case .disabled:
            let color = disabledTextColor
            placeholderLabel.textColor = color
            textField.textColor = color
            borderView.backgroundColor = normalBorderColor
        }
        errorLabel.isHidden = !isError
        textField.isEnabled = state != .disabled
        
        UIView.animate(withDuration: 0.3, delay: 0, options:.curveEaseOut) { [weak self] in
            guard let self = self else { return }
            self.updateStyle(with: state)
            self.layoutIfNeeded()
        }
    }
    
    private func updateStyle(with state: TextFieldState) {
        placeholderStyle(with: state)
        
        let thickness: CGFloat
        switch state {
        case .error(_):
            thickness = 2
            placeholderLeftConstraint?.errorAnimation(self, from: 4, to: 0)
            // TODO: 테스트 필요
            Vibration.error.vibrate()
        case .editing: thickness = 2
        default: thickness = 1
        }
        borderStyle(with: thickness)
    }
    
    private func borderStyle(with thickness: CGFloat) {
        borderView.snp.remakeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
            $0.height.equalTo(thickness)
        }
    }
    
    private func placeholderStyle(with state: TextFieldState) {
        guard let text = textField.text, !text.isEmpty || state == .editing else {
            placeholderLabel.transform = .identity
            return
        }
        
        let scale = CGAffineTransform(scaleX: 0.75, y: 0.75)
        let move = CGAffineTransform(translationX: -3.93, y: -19)
        placeholderLabel.transform = scale.concatenating(move)
    }
    
    func showError(with message: String) {
        guard let text = textField.text, !text.isEmpty else { return }
        setState(state: .error(title: message))
    }
}

extension Reactive where Base: UITextField {
    /// text 값이 변경될 때, keyboard 입력 될 때
    var textChanged: Observable<String?> {
        return Observable.merge(self.base.rx.observe(String.self, "text"),
                                self.base.rx.controlEvent(.editingChanged).withLatestFrom(self.base.rx.text))
    }
}

extension Reactive where Base: SingleLineTextField {
    var textFieldChanged: ControlEvent<(SingleLineTextField, String?)> {
        let source: Observable<(SingleLineTextField, String?)> = self.base.textField.rx.textChanged
            .flatMap { _ in Observable.just((self.base, self.base.textField.text)) }
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
