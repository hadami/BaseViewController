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

class SingleLineTextField: UIView, ReactorKit.View, ConfigurableContainerView {
    typealias DataType = SingleLineTextFieldReactor
    func configure(data: SingleLineTextFieldReactor) {
        bind(reactor: data)
    }
    func bind(reactor: SingleLineTextFieldReactor) {
        setState(state: reactor.currentState.type)
    }
    
    var textField: UITextField = {
        let v = UITextField()
        v.font = .systemFont(ofSize: 18)
        v.tintColor = .black
        v.textColor = .black
        v.borderStyle = .none
        return v
    }()
    
    fileprivate var deleteButton: UIButton = {
        let v = UIButton.init(type: .system)
        v.setTitle("x", for: .normal)
        return v
    }()
    
    fileprivate var placeholderLabel: UILabel = {
        let v = UILabel()
        v.text = "placeholder"
        v.font = .systemFont(ofSize: 12)
        v.textColor = .gray
        return v
    }()
    
    fileprivate var helperLabel: UILabel = {
        let v = UILabel()
        v.font = .systemFont(ofSize: 12)
        v.textColor = .red
        return v
    }()
    
    fileprivate var lineView: UIView = {
        let v = UIView()
        v.backgroundColor = .lightGray
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
        addSubview(deleteButton)
        addSubview(placeholderLabel)
        addSubview(helperLabel)
        addSubview(lineView)
        
        placeholderLabel.snp.remakeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.left.equalToSuperview()
            $0.height.equalTo(18)
        }
        
        textField.snp.remakeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalToSuperview().inset(39)
            $0.top.equalToSuperview().inset(32)
            $0.bottom.equalToSuperview().inset(30)
        }
        
        deleteButton.snp.remakeConstraints {
            $0.right.equalToSuperview()
            $0.centerY.equalToSuperview().offset(2)
        }
        
        lineView.snp.remakeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
            $0.height.equalTo(1)
        }
        
        helperLabel.snp.remakeConstraints {
            $0.left.bottom.equalToSuperview()
            $0.height.equalTo(18)
        }
    }
    
    private func setupRx() {
        deleteButton.rx.tap.subscribe({ [weak self] _ in
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
        switch state {
        case .editing:
            let color = UIColor.blue
            self.placeholderLabel.textColor = .gray
            self.lineView.backgroundColor = color
            self.helperLabel.text = ""
        case .error(let title):
            let color = UIColor.red
            self.placeholderLabel.textColor = color
            self.lineView.backgroundColor = color
            self.helperLabel.text = title
        case .done:
            self.placeholderLabel.textColor = .gray
            self.lineView.backgroundColor = .gray
            self.helperLabel.text = ""
        case .disabled:
            let color = UIColor.lightGray
            self.placeholderLabel.textColor = color
            self.textField.textColor = color
            self.lineView.backgroundColor = color
            self.helperLabel.text = ""
        }
        deleteButton.isHidden = (state == .editing) ? false : true
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
