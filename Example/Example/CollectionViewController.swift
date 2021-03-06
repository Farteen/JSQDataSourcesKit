//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://jessesquires.com/JSQDataSourcesKit
//
//
//  GitHub
//  https://github.com/jessesquires/JSQDataSourcesKit
//
//
//  License
//  Copyright © 2015 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

import UIKit

import JSQDataSourcesKit


class CollectionViewController: UICollectionViewController {

    typealias CellFactory = CollectionViewCellFactory<CollectionViewCell, CellViewModel>
    typealias HeaderViewFactory = TitledCollectionReusableViewFactory<CellViewModel>
    typealias Section = CollectionViewSection<CellViewModel>

    var dataSourceProvider: CollectionViewDataSourceProvider<Section, CellFactory, HeaderViewFactory>?


    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView(collectionView!)

        // 1. create view models
        let section0 = CollectionViewSection(items: CellViewModel(), CellViewModel(), CellViewModel())
        let section1 = CollectionViewSection(items: CellViewModel(), CellViewModel(), CellViewModel(), CellViewModel(), CellViewModel(), CellViewModel())
        let section2 = CollectionViewSection(items: CellViewModel())
        let allSections = [section0, section1, section2]

        // 2. create cell factory
        let cellFactory = CollectionViewCellFactory(reuseIdentifier: CellId) {
            (cell: CollectionViewCell, model: CellViewModel, collectionView: UICollectionView, indexPath: NSIndexPath) -> CollectionViewCell in
            cell.label.text = model.text + "\n\(indexPath.section), \(indexPath.item)"
            return cell
        }

        // 3. create supplementary view factory
        let headerFactory = TitledCollectionReusableViewFactory(
            dataConfigurator: { (header, item: CellViewModel, kind, collectionView, indexPath) -> TitledCollectionReusableView in
                header.label.text = "Section \(indexPath.section)"
                return header
            },
            styleConfigurator: { (headerView) -> Void in
                headerView.backgroundColor = .darkGrayColor()
                headerView.label.textColor = .whiteColor()
        })

        // 4. create data source provider
        self.dataSourceProvider = CollectionViewDataSourceProvider(
            sections: allSections,
            cellFactory: cellFactory,
            supplementaryViewFactory: headerFactory,
            collectionView: collectionView)
    }
}
