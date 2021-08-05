//
//  CellContainer.swift
//  Base
//
//  Created by chloe on 2021/08/06.
//

import SnapKit
import UIKit

protocol ConfigurableContainerView: UIView {
//    associatedtype Delegate
    associatedtype DataType

//    var delegate: Delegate? { get set }
    func configure(data: DataType)
}
protocol GenericCellIdentifier {
    static var reuseIdentifier: String { get }
}

protocol ConfigurableCell: GenericCellIdentifier {
    associatedtype ViewType: ConfigurableContainerView
    
    var view: ViewType { get }
}
extension ConfigurableCell {
    static var reuseIdentifier: String {
        return String(describing: ViewType.self)
    }
}

class GenericTableViewCell<T: ConfigurableContainerView>: UITableViewCell, ConfigurableCell {
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
        let cv = contentView
        cv.addSubview(view)
        view.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

//class GenericCollectionViewCell<T: ConfigurableContainerView>: UICollectionViewCell, ConfigurableCell {
//    typealias ViewType = T
//
//    private(set) lazy var view: ViewType = ViewType()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setupView()
//    }
//
//    private func setupView() {
//        let cv = contentView
//        cv.addSubview(view)
//        cv.snp.remakeConstraints {
//            $0.edges.equalToSuperview()
//        }
//    }
//}
