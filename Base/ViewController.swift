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
        
        var items = [CellConfigurator]()
        for _ in 0..<10 {
            let conf = TableComps.Conf.SingleLineTextField(item: .init(type: .done))
            let buttonConf = TableComps.Conf.BottomButton(item: .init(type: .scrollable(title: "확인", state: .primary, type: .H52)))
            items.append(conf)
            items.append(buttonConf)
        }
        vc.reactor = .init(items: items)
        goTo(vc: vc)
    }
    
    @IBAction func goToCollection(_ sender: Any) {
        let vc = CollectionViewController()
        goTo(vc: vc)
    }
}

