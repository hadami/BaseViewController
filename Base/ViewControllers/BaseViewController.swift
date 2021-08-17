//
//  BaseViewController.swift
//  Base
//
//  Created by chloe on 2021/08/04.
//

import UIKit
import RxSwift
import SnapKit

class BaseViewController<T: UIView>: UIViewController {
    
    typealias ViewType = T
    
    private(set) var navigationView = BaseNavigationBar()
    var baseView: ViewType
    
    var disposeBag = DisposeBag()
    
    convenience init() {
        if let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()) as? ViewType {
            self.init(view: collectionView)
        } else {
            self.init(view: ViewType())
        }
    }
    
    init(view: ViewType) {
        baseView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit - \(String(describing: type(of: self)))")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(navigationView)
        view.addSubview(baseView)
        navigationView.snp.remakeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(navigationView.isHidden ? 0 : 56)
        }
        baseView.snp.remakeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
//            $0.bottom.lessThanOrEqualToSuperview()
        }
        
        setupRx()
    }
    
    private func setupRx() {
        self.navigationView.rx.closeButtonTap.subscribe({ [weak self] _ in
            guard let self = self else { return }
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
    }
}
