//
//  BaseNavigationView.swift
//  Base
//
//  Created by chloe on 2021/08/04.
//

import ReactorKit
import RxCocoa
import RxSwift
import SnapKit
import UIKit

class BaseNavigationView: UIView {
    
    fileprivate var closeButton: UIButton = {
        let v = UIButton.init(type: .system)
        v.setTitle("close", for: .normal)
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
        addSubview(closeButton)
        backgroundColor = .lightGray
        closeButton.snp.remakeConstraints {
            $0.right.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
    }
}

extension Reactive where Base: BaseNavigationView {
    var closeButtonTap: ControlEvent<Void> {
        let source: Observable<Void> = self.base.closeButton.rx.tap.asObservable()
      return ControlEvent(events: source)
    }
}
