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
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func goToStack(_ sender: Any) {
        let vc = StackViewController()//view: ScrollStackView(insets: .init(top: 20, left: 20, bottom: 20, right: 20)))
        goTo(vc: vc)
    }
    
    @IBAction func goToTable(_ sender: Any) {
        let vc = TableViewController()
        goTo(vc: vc)
    }
    
    @IBAction func goToCollection(_ sender: Any) {
        let vc = CollectionViewController()
        goTo(vc: vc)
    }
}

