//
//  CellComponent.swift
//  Base
//
//  Created by chloe on 2021/08/16.
//

import ReactorKit

protocol GenericCellList {
    associatedtype Cell
    var cellTypeList: [Cell.Type] { get set }
}

struct Component {
    struct Table {
        typealias Cell<ViewType: ConfigurableContainerView> = GenericTableViewCell<ViewType>
        typealias Configurator<ViewType: ConfigurableContainerView> = TableCellConfigurator<Component.Table.Cell<ViewType>>
    }
    struct Collection {
        typealias Cell<ViewType: ConfigurableContainerView> = GenericCollectionViewCell<ViewType>
        typealias Configurator<ViewType: ConfigurableContainerView> = CollectionCellConfigurator<Component.Collection.Cell<ViewType>>
    }
}


