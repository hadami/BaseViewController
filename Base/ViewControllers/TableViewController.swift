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

struct TableComps {
    /// Cell typealias
    struct Cell {
        typealias SingleLineTextFieldCell = GenericTableViewCell<SingleLineTextField>
        typealias BottomButtonCell = GenericTableViewCell<BottomButtonView>
        
        static var allTypes: [UITableViewCell.Type] {
            return [
                TableComps.Cell.SingleLineTextFieldCell.self,
                TableComps.Cell.BottomButtonCell.self
            ]
        }
    }
    
    /// Configurator typealias
    struct Conf {
        typealias SingleLineTextField = TableCellConfigurator<TableComps.Cell.SingleLineTextFieldCell>
        typealias BottomButton = TableCellConfigurator<TableComps.Cell.BottomButtonCell>
    }
}

class TableViewReactor: Reactor {
    enum ActionType {
    }
    
    enum Action {
    }
    
    enum Mutation {
    }
    
    struct State {
        let items: [CellConfigurator]
    }
    
    let initialState: State
    
    init(items: [CellConfigurator]) {
        initialState = State(items: items)
    }
}

class TableViewController: BaseViewController<UITableView>, ReactorKit.View {
    
    var itemArray = [CellConfigurator]() {
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
        
        TableComps.Cell.allTypes.forEach({ e in
            if let identifier = e as? GenericCellIdentifier.Type {
                baseView.register(e, forCellReuseIdentifier: identifier.reuseIdentifier)
            }
        })
    }
    
    func bind(reactor: TableViewReactor) {
        itemArray = reactor.currentState.items
    }
}

extension TableViewController: UITableViewDelegate {
    
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 0
        let item = itemArray[indexPath.row]
        height = item.rowHeight(availableWidth: tableView.frame.width)
        
        return height
    }
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
