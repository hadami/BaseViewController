//
//  EmptyView.swift
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

//typealias MEmptyConfigurator = DefaultBase<MEmpty, MEmptyReactor>
final class EmptyViewReactor: Reactor {

    enum Action {
    }

    enum Mutation {
    }
    
    struct State {
        var height: CGFloat
    }

    let initialState: State

    init(height: CGFloat) {
        self.initialState = State(height: height)
    }
}

final class EmptyView: GenericContainerView<EmptyViewReactor> {
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("deinit - \(String(describing: type(of: self)))")
    }

    override func bind(reactor: Reactor) {
        backgroundColor = .black
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        guard let height = reactor?.currentState.height else { return }
        
        self.snp.remakeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(height)
        }
    }
}
