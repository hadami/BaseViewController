//
//  TableViewController.swift
//  Base
//
//  Created by chloe on 2021/08/04.
//

import ReactorKit
import RxCocoa
import RxSwift
import UIKit

//protocol GenericTableView {
//    associatedtype CellType: ConfigurableCell where CellType: UITableViewCell
//
//    var viewType: CellType.ViewType.Type { get }
//    var confType: TableCellConfigurator<CellType>.Type { get }
//    var cellType: CellType.Type { get }
//}
//
//protocol GenericTableViewType: GenericTableView { }
//extension GenericTableViewType {
//    var viewType: CellType.ViewType.Type {
//        return TableCellConfigurator<CellType>.viewType
//    }
//    var confType: TableCellConfigurator<CellType>.Type {
//        return TableCellConfigurator<CellType>.confType
//    }
//    var cellType: CellType.Type {
//        return TableCellConfigurator<CellType>.cellType
//    }
//}
//
//class GenericTableComponent<T: ConfigurableContainerView>: GenericTableViewType {
//    typealias ViewType = T
//    typealias CellType = GenericTableViewCell<T>
//
//    init() {
//        let v = self.viewType
//        let t = self.confType
//        let c = self.cellType
//        print(t)
//        print(c)
////        TableCellConfigurator<GenericTableViewCell<SingleLineTextField>>
////        GenericTableViewCell<SingleLineTextField>
//    }
//}

class TableViewReactor: Reactor {
    enum ActionType {
    }
    
    enum Action {
    }
    
    enum Mutation {
    }
    
    struct State {
        let items: [GenericCellConfigurator]
    }
    
    let initialState: State
    
    init(items: [GenericCellConfigurator]) {
        initialState = State(items: items)
    }
}

class TableViewController: BaseViewController<UITableView>, ReactorKit.View, GenericCellList {
    var cellTypeList: [UITableViewCell.Type] = [] {
        didSet {
            cellTypeList.forEach({ type in
                if let identifier = type as? GenericCellIdentifier.Type {
                    baseView.register(type, forCellReuseIdentifier: identifier.reuseIdentifier)
                }
            })
        }
    }
    
    var itemArray = [GenericCellConfigurator]() {
        didSet {
            baseView.reloadData()
        }
    }
    
    deinit {
        print("deinit - \(String(describing: type(of: self)))")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseView.delegate = self
        baseView.dataSource = self
        
        cellTypeList = [
            GenericTable.Cell<SingleLineTextField>.self,
            GenericTable.Cell<BaseButton>.self,
            GenericTable.Cell<ButtonStackView>.self
        ]
    }
    
    func setSelectedColor(_ color: UIColor, cell: UITableViewCell) {
        let v = UIView()
        v.backgroundColor = .red
        cell.selectedBackgroundView = v
    }
    
    func bind(reactor: TableViewReactor) {
        itemArray = reactor.currentState.items
    }
}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        baseView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension TableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        var height: CGFloat = 0
//        let item = itemArray[indexPath.row]
//        height = item.rowHeight(availableWidth: tableView.frame.width)
//        
//        return height
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = itemArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseIdentifier, for: indexPath)
        item.configure(cell: cell)
        return cell
    }
    
    
}
