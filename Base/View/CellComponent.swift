//
//  CellComponent.swift
//  Base
//
//  Created by chloe on 2021/08/16.
//


protocol GenericCellList {
    associatedtype Cell
    var cellTypeList: [Cell.Type] { get set }
}

struct GenericTable {
    typealias Cell<ViewType: ConfigurableContainerView> = GenericTableViewCell<ViewType>
    typealias Configurator<ViewType: ConfigurableContainerView> = TableCellConfigurator<GenericTable.Cell<ViewType>>
}

struct GenericCollection {
    typealias Cell<ViewType: ConfigurableContainerView> = GenericCollectionViewCell<ViewType>
    typealias Configurator<ViewType: ConfigurableContainerView> = CollectionCellConfigurator<GenericCollection.Cell<ViewType>>
}

