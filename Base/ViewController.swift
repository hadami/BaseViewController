//
//  ViewController.swift
//  Base
//
//  Created by chloe on 2021/08/04.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
            let conf = GenericTable.Configurator<SingleLineTextField>(item: .init(type: .done))
            let buttonConf = GenericTable.Configurator<BaseButton>(item: .init(type: .scrollable(title: "확인", state: .primary, type: .H52)))
            let stackConf = GenericTable.Configurator<ButtonStackView>(item: .init(type: (.scrollable(title: "취소", state: .secondary(color: .gray), type: .H52),
                                                                                   .scrollable(title: "확인", state: .primary, type: .H52))))
            items.append(conf)
            items.append(stackConf)
        }
        vc.reactor = .init(items: items)
        goTo(vc: vc)
    }
    
    @IBAction func goToCollection(_ sender: Any) {
        let vc = CollectionViewController()
        var items = [GenericCellConfigurator]()
        for _ in 0..<10 {
            let buttonConf = GenericCollection.Configurator<BaseButton>(item: .init(type: .scrollable(title: "확인", state: .primary, type: .H52)))
            items.append(buttonConf)
        }
        vc.reactor = .init(items: items)
        goTo(vc: vc)
    }
}

