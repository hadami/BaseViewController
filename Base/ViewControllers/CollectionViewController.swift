//
//  CollectionViewController.swift
//  Base
//
//  Created by chloe on 2021/08/04.
//

import UIKit

class CollectionViewController: BaseViewController<UICollectionView> {
    
    deinit {
        print("deinit - \(String(describing: type(of: self)))")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
