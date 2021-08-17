//
//  CellConfigurator.swift
//  Base
//
//  Created by chloe on 2021/08/05.
//

import UIKit

protocol GenericCellConfigurator: GenericCellIdentifier {
    func configure(cell: UIView)
}

final class TableCellConfigurator<CellType: GenericContainerCell>: GenericCellConfigurator where CellType: UITableViewCell {
    
    static var viewType: CellType.ViewType.Type { return CellType.ViewType.self }
    static var cellType: CellType.Type { return CellType.self }
    static var confType: TableCellConfigurator.Type { return TableCellConfigurator.self }
    static var reuseIdentifier: String { return CellType.reuseIdentifier }
    
    let item: CellType.ViewType.DataType
    
    init(item: CellType.ViewType.DataType) {
        self.item = item
    }
    
    func configure(cell: UIView) {
        guard let configurableInstance = cell as? CellType else { return }
        configurableInstance.view.configure(data: item)
    }
}

final class CollectionCellConfigurator<CellType: GenericContainerCell>: GenericCellConfigurator where CellType: UICollectionViewCell {

    static var viewType: CellType.ViewType.Type { return CellType.ViewType.self }
    static var cellType: CellType.Type { return CellType.self }
    static var confType: CollectionCellConfigurator.Type { return CollectionCellConfigurator.self }
    static var reuseIdentifier: String { return CellType.reuseIdentifier }

    let item: CellType.ViewType.DataType

    init(item: CellType.ViewType.DataType) {
        self.item = item
    }

    func configure(cell: UIView) {
        guard let configurableInstance = cell as? CellType else { return }
        configurableInstance.view.configure(data: item)
    }
}
