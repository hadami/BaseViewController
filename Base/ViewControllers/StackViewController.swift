//
//  StackViewController.swift
//  Base
//
//  Created by chloe on 2021/08/04.
//

import UIKit
import SnapKit

class StackViewController: BaseViewController<ScrollStackView> {
    override init(view: BaseViewController<ScrollStackView>.ViewType) {
        super.init(view: view)
        
//        navigationView.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit - \(String(describing: type(of: self)))")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let label = ViewConfigurator<SingleLabel, SingleLabelReactor>.init(item: .init(title: .init(title: <#T##NSAttributedString#>)))
        let phoneTextField = SingleLineTextField()
        let telecomTextField = SingleLineTextField()
        let birthTextField = SingleLineTextField()
        let nameTextField = SingleLineTextField()
//        let view = DefaultButtonView()
//        view.reactor = .init(type: .bottomFixed(title: "확인", state: .primary))
        
        let array = [phoneTextField, telecomTextField, birthTextField, nameTextField,
                     phoneTextField, telecomTextField, birthTextField, nameTextField,
                     phoneTextField, telecomTextField, birthTextField, nameTextField,
                     phoneTextField, telecomTextField, birthTextField, nameTextField]
        
        for _ in array {
            let attr = NSAttributedString(string: "휴대폰 번호를\n입력해주세요")
            var textField =
//                Component.Configurator<SingleLabel.Reactor>(item: .init(title: .init(title: attr)))
                ViewConfigurator<SingleLabel>(item: .init(title: .init(title: attr)))

//SingleLineTextField()
            baseView.stackView.addArrangedSubview(textField.view)
//            textField.rx.textFieldChanged.subscribe(onNext: { textField in
//                print(textField)
//            }).disposed(by: disposeBag)
//
//            textField.rx.textFieldFocusIn.subscribe(onNext: { textField in
//                print(textField)
//            }).disposed(by: disposeBag)
//
//            textField.rx.textFieldFocusOut.subscribe(onNext: { textField in
//                print(textField)
//            }).disposed(by: disposeBag)

        }
        
//        for view in baseView.stackView.arrangedSubviews {
//            view.snp.remakeConstraints {
//                $0.height.equalTo(86)
//            }
//        }
    }

}
