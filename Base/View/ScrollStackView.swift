//
//  ScrollStackView.swift
//  Base
//
//  Created by chloe on 2021/08/04.
//

import UIKit

class ScrollStackView: UIScrollView {
    var stackView: UIStackView
    
    convenience init() {
        self.init(stackView: nil, insets: .zero)
    }
    
    init(stackView: UIStackView? = nil, insets: UIEdgeInsets = .zero) {
        let v = UIStackView()
        v.axis = .vertical
        self.stackView = stackView ?? v
        super.init(frame: .zero)
        setupUI(insets: insets)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("deinit - \(String(describing: type(of: self)))")
    }
    
    private func setupUI(insets: UIEdgeInsets = .zero) {
        
        addSubview(stackView)
        
        stackView.snp.remakeConstraints {
            $0.edges.equalToSuperview().inset(insets)
            
            switch stackView.axis {
            case .horizontal:
                let offset = -(insets.top + insets.bottom)
                $0.height.equalToSuperview().offset(offset)
            case .vertical:
                let offset = -(insets.right + insets.left)
                $0.width.equalToSuperview().offset(offset)
            default: ()
            }
        }
    }


}
