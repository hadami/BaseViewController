//
//  BaseNavigationBar.swift
//  Base
//
//  Created by chloe on 2021/08/04.
//

import ReactorKit
import RxCocoa
import RxSwift
import SnapKit
import UIKit

class BaseNavigationBar: UIView {
    
    fileprivate var backButton: UIButton = {
        let v = UIButton.init(type: .system)
        v.setImage(#imageLiteral(resourceName: "backward"), for: .normal)
//        v.tintColor = UIColor(displayP3Red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        return v
    }()
    fileprivate var titleLabel: UILabel = {
        let v = UILabel()
        v.text = ""
        return v
    }()
    fileprivate var moreButton: UIButton = {
        let v = UIButton.init(type: .system)
        v.setImage(#imageLiteral(resourceName: "more"), for: .normal)
        return v
    }()
    fileprivate var closeButton: UIButton = {
        let v = UIButton.init(type: .system)
        v.setImage(#imageLiteral(resourceName: "close"), for: .normal)
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
        backgroundColor = .white
        
        let stackView = UIStackView(arrangedSubviews: [moreButton, closeButton])
        stackView.axis = .horizontal
        stackView.spacing = 0
        
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(stackView)
        
        backButton.snp.remakeConstraints {
            $0.left.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(44)
        }
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        titleLabel.snp.remakeConstraints {
            $0.center.equalToSuperview()
            $0.left.greaterThanOrEqualTo(backButton.snp.right)
            $0.right.lessThanOrEqualTo(stackView.snp.left)
        }
        moreButton.snp.remakeConstraints {
            $0.width.height.equalTo(44)
        }
        closeButton.snp.remakeConstraints {
            $0.width.height.equalTo(44)
        }
        stackView.snp.remakeConstraints {
            $0.right.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
    }
}

extension Reactive where Base: BaseNavigationBar {
    var backButtonTap: ControlEvent<Void> {
        let source: Observable<Void> = self.base.backButton.rx.tap.asObservable()
      return ControlEvent(events: source)
    }
    var moreButtonTap: ControlEvent<Void> {
        let source: Observable<Void> = self.base.moreButton.rx.tap.asObservable()
      return ControlEvent(events: source)
    }
    var closeButtonTap: ControlEvent<Void> {
        let source: Observable<Void> = self.base.closeButton.rx.tap.asObservable()
      return ControlEvent(events: source)
    }
}
