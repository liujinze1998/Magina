//
//  AlbumDataSource.swift
//  Magina
//
//  Created by AM on 2024/3/7.
//

import Foundation
import Photos

public class AlbumDataSource : NSObject {
    public var uncategorizedDataReady : (() -> Void)?
    public var categoryFetchCompletion : ((String) -> Void)?
    
    private var categoryDict : [String : CategoryDataSource] = [:]
    private var dictRecursiveMutexLock : pthread_mutex_t
    private var needFetchData : Bool = true
    public var fetchResult : PHFetchResult<PHAsset>?
    public var count : Int {
        return fetchResult?.count ?? 0
    }
    internal var libraryObserver : LibraryObserver?
    private var libraryToken: Any?
    public private(set) var currentCollectionModel : AlbumModel?
    public private(set) var collectionModels : [AlbumModel]
    
    public init(currentCollectionModel : AlbumModel?, collectionModels: [AlbumModel]) {
        self.collectionModels = collectionModels
        self.currentCollectionModel = currentCollectionModel
        self.fetchResult = self.currentCollectionModel?.fetchResult
        self.dictRecursiveMutexLock = pthread_mutex_t()
        var attr = pthread_mutexattr_t()
        pthread_mutexattr_init(&attr)
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE)
        pthread_mutex_init(&dictRecursiveMutexLock, &attr)
    }
    
    deinit {
        pthread_mutex_destroy(&dictRecursiveMutexLock)
    }
    
    public func setDataLibraryObserveToken(token: Any) {
        libraryToken = token
    }
    
    public func fetchDataIfNeeded() {
        guard let currentCollectionModel, needFetchData == true else {
            return
        }
        if currentCollectionModel.fetchResult == nil {
            //handle quick create self
            currentCollectionModel.loadFetchResultIfNeeded()
            libraryObserver?.globalFetchResult = currentCollectionModel.fetchResult
            self.fetchResult = self.currentCollectionModel?.fetchResult
        }
        self.uncategorizedDataReady?()
        let models : [CategoryModel] = AlbumFactory().descriptionOfCategory()
        self.fetchCategoryData(contexts: models)
        needFetchData = false
    }
    
    private func fetchCategoryData(contexts: [CategoryModel]) {
        guard let currentCollectionModel = self.currentCollectionModel else {
            return
        }
        let categoryContexts = contexts
        for context in categoryContexts {
            if context.isFavorite == false && context.type == nil {
                let categoryID = context.name
                let categoryDataSource = CategoryDataSource(categoryID: categoryID, result: self.currentCollectionModel?.fetchResult)
                self.setCategorySource(categoryID: categoryID, container: categoryDataSource)
                self.libraryObserver?.addCategoryDictSource(categoryID, result:currentCollectionModel.fetchResult)
                self.categoryFetchCompletion?(categoryID)
                continue
            }
            DispatchQueue.global().async {
                RequestManager.shared.getResultFromCollection(collection: currentCollectionModel, type: context.type, isFavorite: context.isFavorite, completion: { [weak self] originFetchResult in
                    guard let self = self else {
                        return
                    }
                    let categoryID = context.name
                    let categoryDataSource = CategoryDataSource(categoryID: categoryID, result: originFetchResult)
                    self.setCategorySource(categoryID: categoryID, container: categoryDataSource)
                    self.libraryObserver?.addCategoryDictSource(categoryID, result: originFetchResult)
                    self.categoryFetchCompletion?(categoryID)
                })
            }
        }
    }
}

extension AlbumDataSource {
    public func albumCollectionAtIndex(_ index: Int) -> AlbumModel? {
        if index >= collectionModels.count || index < 0 {
            return nil
        }
        return collectionModels[index]
    }
    
    public func updateCurrentAlbumCollectionWithIndex(_ index : Int) {
        if index >= collectionModels.count || index < 0 {
            return
        }
        currentCollectionModel = collectionModels[index]
        guard let currentCollectionModel else {
            return
        }
        libraryObserver?.globalFetchResult = currentCollectionModel.fetchResult
        needFetchData = true
        fetchDataIfNeeded()
    }
    
    internal func appendRemainingAlbums(_ collections: [AlbumModel]) {
        if collectionModels.isEmpty {
            currentCollectionModel = collections.first
            guard let currentCollectionModel else {
                return
            }
            libraryObserver?.globalFetchResult = currentCollectionModel.fetchResult
            needFetchData = true
            fetchDataIfNeeded()
        }
        collectionModels.append(contentsOf: collections)
    }
}

extension AlbumDataSource : LibraryChangeConsumer {
    func applyLibraryGlobalChange(_ change: PHChange) {
        guard let fetchResult else {
            return
        }
        if let detail = change.changeDetails(for: fetchResult) {
            let newResult = detail.fetchResultAfterChanges
            self.fetchResult = newResult
        }
        updateAlbumsSource(change)
    }
    
    func applyLibraryCategoryChange(details: [String : PHFetchResultChangeDetails<PHAsset>]) {
        if details.isEmpty {
            return
        }
        for (categoryID, changeDetail) in details {
            if let categoryDataSource = categorySourceBy(categoryID: categoryID) {
                let newFetchResult = changeDetail.fetchResultAfterChanges
                if changeDetail.hasIncrementalChanges {
                    categoryDataSource.applyMediaDiff(diff: changeDetail, newValue: newFetchResult)
                } else {
                    categoryDataSource.updateFetchResult(newFetchResult)
                }
            }
        }
    }
    
    func updateAlbumsSource(_ changeInstance: PHChange) {
        for album in collectionModels {
            if let oldResult = album.fetchResult, let changeDetail = changeInstance.changeDetails(for: oldResult) {
                album.update(result: changeDetail.fetchResultAfterChanges)
            }
        }
    }
}


extension AlbumDataSource {
    public func categorySourceBy(categoryID: String) -> CategoryDataSource? {
        var result : CategoryDataSource?
        pthread_mutex_lock(&dictRecursiveMutexLock)
        result = categoryDict[categoryID]
        pthread_mutex_unlock(&dictRecursiveMutexLock)
        return result
    }
    
    private func setCategorySource(categoryID: String, container: CategoryDataSource?) {
        guard let container else {
            return
        }
        pthread_mutex_lock(&dictRecursiveMutexLock)
        categoryDict[categoryID] = container
        pthread_mutex_unlock(&dictRecursiveMutexLock)
    }
}
