//
//  ViewController.swift
//  Base
//
//  Created by chloe on 2021/08/04.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(textField)
//        textField.delegate = self
//        self.textField.isEnabled = false
        
        textField.rx.controlEvent([.editingDidBegin]).subscribe({ [weak self] _ in
            guard let self = self else { return }
            print("editingDidBegin")
//            self.textField.isSelected = true
            self.textField.isEnabled = false
        }).disposed(by: disposeBag)
    }
    
    private func goTo(vc: UIViewController) {
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func goToStack(_ sender: Any) {
        let vc = StackViewController()//view: ScrollStackView(insets: .init(top: 20, left: 20, bottom: 20, right: 20)))
        goTo(vc: vc)
    }
    
    @IBAction func goToTable(_ sender: Any) {
        let vc = TableViewController()
        
        var items = [GenericCellConfigurator]()
        for _ in 0..<10 {
            let empty = Component.Table.Configurator<EmptyView>(item: .init(height: 50))
            let label = Component.Table.Configurator<SingleLabel>(item: .init(title: .init(title: NSAttributedString(string: "SingleLabel"))))
            let conf = Component.Table.Configurator<SingleLineTextField>(item: .init())
            let buttonConf = Component.Table.Configurator<BaseButton>(item: .init(type: .scrollable(title: "확인", state: .primary, type: .H52)))
            items.append(label)
            items.append(empty)
            items.append(conf)
        }
        vc.reactor = .init(items: items)
        goTo(vc: vc)
    }
    
    @IBAction func goToCollection(_ sender: Any) {
        let vc = CollectionViewController()
        var items = [GenericCellConfigurator]()
        for _ in 0..<10 {
            let buttonConf = Component.Collection.Configurator<BaseButton>(item: .init(type: .scrollable(title: "확인", state: .primary, type: .H52)))
            items.append(buttonConf)
        }
        vc.reactor = .init(items: items)
        goTo(vc: vc)
    }
}

