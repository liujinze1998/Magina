//
//  albumCategoryViewController.swift
//  Magina
//
//  Created by AM on 2024/3/8.
//

import Foundation
import UIKit
import Photos

class AlbumCategoryViewController : UIViewController{
    var albumDataSource: CategoryDataSource?
    var viewModel: AlbumViewModel
    var categoryID: String
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        var itemWidth = floor((view.bounds.width - 5)/4)
        let itemSize = CGSize(width: itemWidth, height: itemWidth)
        flowLayout.itemSize = itemSize
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.minimumLineSpacing = 1;
        let collection = UICollectionView(frame: CGRectZero, collectionViewLayout: flowLayout)
        collection.delegate = self
        collection.dataSource = self
        collection.alwaysBounceVertical = true
        collection.showsVerticalScrollIndicator = false
        collection.bounces = true
        collection.backgroundColor = UIColor.lightGray
        collection.register(AlbumMediaCell.self, forCellWithReuseIdentifier: "AlbumMediaCell")
        return collection
    }()
    
    init(viewModel: AlbumViewModel, categoryID: String) {
        self.viewModel = viewModel
        self.categoryID = categoryID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = AlbumViewModel(categoryModels: AlbumFactory().descriptionOfCategory())
        self.categoryID = ""
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
    }
    
    deinit {
        self.albumDataSource?.removeSubscriber(self)
    }
}

extension AlbumCategoryViewController{
    func updateCollectionFrame() {
        collectionView.frame = view.bounds
    }
    
    func reloadCategoryData(_ container: CategoryDataSource) {
        self.albumDataSource = container
        self.observeDataSourceChange()
        collectionView.reloadData()
    }
    
    func reverseData(){
        albumDataSource?.reverse()
        reloadData()
    }
    
    func reloadData(){
        collectionView.reloadData()
    }
}

/// UICollectionViewDataSource
extension AlbumCategoryViewController : UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sourceCount()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : AlbumMediaCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumMediaCell", for: indexPath) as! AlbumMediaCell
        if (indexPath.row < self.sourceCount()) {
            let model = albumDataSource?.cellModelAtIndex(index: indexPath.row)
            cell.configWithAsset(model)
        }
        return cell
    }
    
    func sourceCount() -> Int {
        return self.albumDataSource?.count ?? 0
    }
}


extension AlbumCategoryViewController : ContainerSourceChangeSubscriber{
    func observeDataSourceChange() {
        self.albumDataSource?.addSubscriber(self)
    }
    
    var registerID: String {
        return categoryID
    }
    
    func receiveSourceChange(_ diff: PHFetchResultChangeDetails<PHAsset>?, newValue: PHFetchResult<PHAsset>) {
        var oldCount = 0
        if let oldSequenceCount = diff?.fetchResultBeforeChanges.count {
            oldCount = oldSequenceCount
        }
        DispatchQueue.main.async {
            if let existDiff = diff {
                self.collectionView.performBatchUpdates {
                    if let insertSet = existDiff.insertedIndexes, insertSet.count > 0{
                        self.collectionView.insertItems(at: self.convertIndex(insertSet, neetCheck: false, removeSet: existDiff.removedIndexes, itemsCount:oldCount))
                    }
                    if let removeSet = existDiff.removedIndexes, removeSet.count > 0{
                        self.collectionView.deleteItems(at: self.convertIndex(removeSet, neetCheck: true, removeSet: nil, itemsCount:oldCount))
                    }
                    if let changeSet = existDiff.changedIndexes, changeSet.count > 0{
                        self.collectionView.reloadItems(at: self.convertIndex(changeSet, neetCheck: true, removeSet: existDiff.removedIndexes, itemsCount:oldCount))
                    }
                }
            } else  {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func convertIndex(_ indexSet: IndexSet,
                              neetCheck: Bool,
                              removeSet: IndexSet?,
                              itemsCount:Int)->[IndexPath]{
        var indexPaths: [IndexPath] = []
        let enumerableSet = NSIndexSet(indexSet: indexSet)
        enumerableSet.enumerate(using: { index, stop in
            var willRemove = false
            if let removeSet = removeSet {
                NSIndexSet(indexSet: removeSet).enumerate { idx, stop in
                    if idx == index {
                        willRemove = true
                    }
                    stop.pointee = true
                }
            }
            if willRemove == false {
                var resultIndex = index
                if viewModel.reverseData {
                    resultIndex = itemsCount - (index + 1)
                }
                let indexPath = IndexPath(item: resultIndex, section: 0)
                indexPaths.append(indexPath)
            }
        })
        let resultIndexPaths =  indexPaths.filter { item in
            if neetCheck {
                return item.item < itemsCount
            } else {
                return true
            }
        }
        return resultIndexPaths
    }
}
