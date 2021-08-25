//
//  CollectionViewController.swift
//  Base
//
//  Created by chloe on 2021/08/04.
//

import ReactorKit
import RxCocoa
import RxSwift
import UIKit

class CollectionViewReactor: Reactor {
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

class CollectionViewController: BaseViewController<UICollectionView>, ReactorKit.View, GenericCellList {
    
    var cellTypeList: [UICollectionViewCell.Type] = [] {
        didSet {
            cellTypeList.forEach({ type in
                if let identifier = type as? GenericCellIdentifier.Type {
                    baseView.register(type, forCellWithReuseIdentifier: identifier.reuseIdentifier)
                }
            })
        }
    }
    
    var itemArray = [GenericCellConfigurator]() {
        // Section, Row, Type Check
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
        
        if let flowLayout = baseView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        baseView.backgroundColor = .white
        compositionalLayout()
        
        cellTypeList = [
            Component.Collection.Cell<SingleLineTextField>.self,
            Component.Collection.Cell<BaseButton>.self
        ]
    }
    
    func compositionalLayout(){
        guard #available(iOS 13.0, *) else { return }
        
        let size = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
            heightDimension: NSCollectionLayoutDimension.estimated(0)
        )
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        
//        let headerFooterSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1.0),
//            heightDimension: .absolute(40)
//        )
//        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
//            layoutSize: headerFooterSize,
//            elementKind: "SectionHeaderElementKind",
//            alignment: .top
//        )
//        section.boundarySupplementaryItems = [sectionHeader]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        baseView.collectionViewLayout = layout
        
    }
    
    func setSelectedColor(_ color: UIColor, cell: UICollectionViewCell) {
        let v = UIView()
        v.backgroundColor = .red
        cell.selectedBackgroundView = v
    }
    
    func bind(reactor: CollectionViewReactor) {
        itemArray = reactor.currentState.items
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = itemArray[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type(of: item).reuseIdentifier, for: indexPath)
        item.configure(cell: cell)
        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    
}
