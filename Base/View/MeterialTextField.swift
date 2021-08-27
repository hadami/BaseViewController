//
//  MeterialTextField.swift
//  Base
//
//  Created by chloe on 2021/08/27.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa
import SnapKit

final class MeterialTextFieldReactor: Reactor {

    enum Action {
    }

    enum Mutation {
    }
    
    struct State {
        var height: CGFloat
    }

    let initialState: State

    init(height: CGFloat = 0) {
        self.initialState = State(height: height)
    }
}

final class MeterialTextField: GenericContainerView<MeterialTextFieldReactor> {
    var textField: TextField = {
        let v = TextField()
        v.placeholder = "Password"
        v.detail = "At least 8 characters"
        v.clearButtonMode = .whileEditing
//        v.isVisibilityIconButtonEnabled = true
        
        // Setting the visibilityIconButton color.
//        v.visibilityIconButton?.tintColor = Color.green.base.withAlphaComponent(v.isSecureTextEntry ? 0.38 : 0.54)
        
//        view.layout(v).center().left(20).right(20)
        return v
    }()
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(textField)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("deinit - \(String(describing: type(of: self)))")
    }

    override func bind(reactor: Reactor) {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

//        guard let height = reactor?.currentState.height else { return }
        let insets: UIEdgeInsets = .init(top: 100, left: 0, bottom: 100, right: 0)
        
        textField.snp.remakeConstraints {
            $0.edges.equalToSuperview()//.inset(insets)
//            $0.height.equalTo(height)
        }
    }
}
