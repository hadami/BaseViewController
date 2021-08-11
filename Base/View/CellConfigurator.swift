//
//  CellConfigurator.swift
//  Base
//
//  Created by chloe on 2021/08/05.
//

import UIKit

protocol CellConfigurator: GenericCellIdentifier {
    func rowHeight(availableWidth: CGFloat) -> CGFloat
    
    func configure(cell: UIView)
    func configure(cell: UIView, delegate: AnyObject?)
}

final class TableCellConfigurator<CellType: ConfigurableCell>: CellConfigurator where CellType: UITableViewCell {
    
    static var cellType: CellType.Type { return CellType.self }
    static var reuseIdentifier: String { return CellType.reuseIdentifier }
    
    let item: CellType.ViewType.DataType
    
    init(item: CellType.ViewType.DataType) {
        self.item = item
    }
    
    func rowHeight(availableWidth: CGFloat) -> CGFloat {
        return self.rowHeight(availableWidth: availableWidth, data: item)
    }
    
    func configure(cell: UIView) {
        configure(cell: cell, delegate: nil)
    }

    func configure(cell: UIView, delegate: AnyObject?) {
        guard let configurableInstance = cell as? CellType else { return }
        configurableInstance.view.configure(data: item)

//        if let delegateObject = delegate as? CellType.ViewType.Delegate {
//            configurableInstance.view.delegate = delegateObject
//        } else {
//            print("expect protocol: \(CellType.ViewType.Delegate.self). but, actual value : \(String(describing: delegate))")
//        }
    }
}

extension TableCellConfigurator {
    func rowHeight(availableWidth: CGFloat, data: CellType.ViewType.DataType) -> CGFloat {
        let cell = CellType.init()
        cell.view.configure(data: data)
        let availableSize = CGSize(width: availableWidth, height: UIView.layoutFittingCompressedSize.height)
        let size = cell.systemLayoutSizeFitting(availableSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return size.height
    }
}

extension CollectionCellConfigurator {
    func rowHeight(availableWidth: CGFloat, data: CellType.ViewType.DataType) -> CGFloat {
        let cell = CellType.init()
        cell.view.configure(data: data)
        let availableSize = CGSize(width: availableWidth, height: UIView.layoutFittingCompressedSize.height)
        let size = cell.contentView.systemLayoutSizeFitting(availableSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return size.height
    }
}

final class CollectionCellConfigurator<CellType: ConfigurableCell>: CellConfigurator where CellType: UICollectionViewCell {

    static var cellType: CellType.Type { return CellType.self }
    static var reuseIdentifier: String { return CellType.reuseIdentifier }

    let item: CellType.ViewType.DataType

    init(item: CellType.ViewType.DataType) {
        self.item = item
    }

    func rowHeight(availableWidth: CGFloat) -> CGFloat {
        return self.rowHeight(availableWidth: availableWidth, data: item)
    }

    func configure(cell: UIView) {
        configure(cell: cell, delegate: nil)
    }

    func configure(cell: UIView, delegate: AnyObject?) {
        guard let configurableInstance = cell as? CellType else { return }
        configurableInstance.view.configure(data: item)

//        if let delegateObject = delegate as? CellType.ViewType.Delegate {
//            configurableInstance.view.delegate = delegateObject
//        } else {
//            printLog("expect protocol: \(CellType.ViewType.Delegate.self). but, actual value : \(delegate)")
//        }
    }
}
