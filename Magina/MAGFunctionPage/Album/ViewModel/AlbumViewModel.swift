//
//  AlbumViewModel.swift
//  Magina
//
//  Created by AM on 2024/3/7.
//

import Foundation
import UIKit
import Photos

class AlbumViewModel : NSObject {
    var globalDataReadyBlock : ((PHFetchResult<PHAsset>?) -> Void)?
    var categoryDataFetchCompletion : ((String,CategoryDataSource) -> Void)?
    var albumInitBlock: (()->Void)?
    var reverseData: Bool = true
    
    var data : AlbumDataSource?
    var dataInfo: [CategoryModel]
    
    init(categoryModels: [CategoryModel]) {
        self.dataInfo = categoryModels
        super.init()
    }
    
    func startFetch() {
        start(completion: { dataContaienr in
            self.data = dataContaienr
            self.albumInitBlock?()
            dataContaienr?.uncategorizedDataReady = { [weak self] in
                DispatchQueue.main.async {
                    guard let container = dataContaienr else {
                        return
                    }
                    self?.globalDataReadyBlock?(container.fetchResult)
                }
            }
            dataContaienr?.categoryFetchCompletion = { [weak self] categoryID in
                DispatchQueue.main.async {
                    guard let container = dataContaienr else {
                        return
                    }
                    if let CategoryDataSource = container.categorySourceBy(categoryID: categoryID) {
                        self?.categoryDataFetchCompletion?(categoryID,CategoryDataSource)
                    }
                }
            }
            dataContaienr?.fetchDataIfNeeded()
        })
    }
}


extension AlbumViewModel {
    private func start(completion: @escaping (AlbumDataSource?) -> Void) {
        DispatchQueue.global().async { [self] in
            var existCameraRollAlbum = true
            var cameraRollDataContainer : AlbumDataSource?
            RequestManager.shared.getAllAlbumsWithType(type: nil, isFavorite: false, cameraRollCompletion: { currentCollection in
                guard let model = currentCollection else {
                    existCameraRollAlbum = false
                    return
                }
                let container = self.makeDataContainer(models: [model])
                cameraRollDataContainer = container
                completion(container)
            }, otherCompletion: { [weak self] collectionModels, _ in
                DispatchQueue.main.async {
                    if existCameraRollAlbum, let container = cameraRollDataContainer {
                        guard let models = collectionModels else {
                            return
                        }
                        container.appendRemainingAlbums(models)
                    } else {
                        guard let models = collectionModels, let self = self else {
                            completion(nil)
                            return
                        }
                        let container = self.makeDataContainer(models: models)
                        completion(container)
                    }
                }
            })
        }
    }
    
    private func makeDataContainer(models : [AlbumModel]) -> AlbumDataSource {
        let albumDataSource = AlbumDataSource(currentCollectionModel: models.first, collectionModels: models)
        let libraryObserver = LibraryObserver(fetchResult: models.first?.fetchResult)
        libraryObserver.consumer = albumDataSource
        albumDataSource.libraryObserver = libraryObserver
        let token = libraryObserver.attatch(to: PHPhotoLibrary.shared())
        albumDataSource.setDataLibraryObserveToken(token: token)
        return albumDataSource
    }
}
