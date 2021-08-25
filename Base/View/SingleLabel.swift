//
//  SingleLabel.swift
//  Bomapp
//
//  Created by chloe on 2021/08/23.
//  Copyright © 2021 Redvelvet Ventures Inc. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa
import SnapKit

struct LabelStyle {
    let title: NSAttributedString
    let insets: UIEdgeInsets
    
    init(title: NSAttributedString, insets: UIEdgeInsets = .zero) {
        self.title = title
        self.insets = insets
    }
}

struct ImageStyle {
    let image: UIImage
    let insets: UIEdgeInsets
    
    init(image: UIImage, insets: UIEdgeInsets = .zero) {
        self.image = image
        self.insets = insets
    }
}

final class SingleLabelReactor: Reactor {

    enum Action {
    }

    enum Mutation {
    }

    struct State {
        var icon: ImageStyle?
        var prefix: LabelStyle?
        var title: LabelStyle
    }

    let initialState: State
    
    init(icon: ImageStyle? = nil,
         prefix: LabelStyle? = nil,
         title: LabelStyle) {
        self.initialState = State(icon: icon,
                                  prefix: prefix,
                                  title: title)
    }
}

final class SingleLabel: GenericContainerView<SingleLabelReactor> {
    lazy var prefixLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        return label
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.clipsToBounds = false
        return label
    }()

    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    convenience init() {
        self.init(frame: .zero)
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
        addSubview(titleLabel)
    }
    
    override func bind(reactor: Reactor) {
        let state = reactor.currentState
        
        if let style = state.icon {
            iconImageView.image = style.image
        }
        if let style = state.prefix {
            prefixLabel.attributedText = style.title
        }
        titleLabel.attributedText = state.title.title

        // TODO: textAlignment 테스트
//        if let titleAlignment = reactor.currentState.titleAlignment {
//            titleLabel.textAlignment = titleAlignment
//        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        guard let state = reactor?.currentState else { return }
        
        if let style = state.icon {
            addSubview(iconImageView)
            iconImageView.snp.remakeConstraints {
                let insets = style.insets
                $0.top.equalToSuperview().offset(insets.top)
                $0.left.equalToSuperview().offset(insets.left)
                $0.size.equalTo(style.image.size)
            }
        }
        
        if let insets = state.prefix?.insets {
            addSubview(prefixLabel)
            prefixLabel.snp.remakeConstraints {
                $0.edges.equalToSuperview().inset(insets)
            }
        }

        titleLabel.snp.remakeConstraints {
            $0.edges.equalToSuperview().inset(state.title.insets)
        }

    }
}
