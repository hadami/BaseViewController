//
//  CellContainer.swift
//  Base
//
//  Created by chloe on 2021/08/06.
//

import UIKit
import ReactorKit

protocol ConfigurableContainerView: UIView, ReactorKit.View {
    associatedtype DataType
    func configure(data: DataType)
}

protocol GenericCellIdentifier {
    static var reuseIdentifier: String { get }
}

protocol GenericContainerCell: GenericCellIdentifier {
    associatedtype ViewType: ConfigurableContainerView
    
    var view: ViewType { get }
}
extension GenericContainerCell {
    static var reuseIdentifier: String {
        return String(describing: ViewType.self)
    }
}

class GenericTableViewCell<T: ConfigurableContainerView>: UITableViewCell, GenericContainerCell {
    typealias ViewType = T
    let view: ViewType = ViewType()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        contentView.addSubview(view)
        view.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

class GenericCollectionViewCell<T: ConfigurableContainerView>: UICollectionViewCell, GenericContainerCell {
    typealias ViewType = T
    let view: ViewType = ViewType()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        contentView.addSubview(view)
        view.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
