//
//  RequestManager.swift
//  Magina
//
//  Created by AM on 2024/3/7.
//

import Foundation
import Photos
import UIKit

enum AlbumMediaType {
    case video
    case photo
}

public class RequestManager : NSObject {
    public static let shared = RequestManager()
    private static var cachingImageManager : PHCachingImageManager {
        let manager = PHCachingImageManager.init()
        manager.allowsCachingHighQualityImages = false
        return manager
    }
}

extension RequestManager {
    func getAllAlbumsWithType(type: AlbumMediaType?, isFavorite: Bool, cameraRollCompletion: ((AlbumModel?) -> Void)?, otherCompletion: @escaping ([AlbumModel]?, Error?) -> Void) {
        var fetchOptions : PHFetchOptions?
        fetchOptions = nil
        let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
        if cameraRollCompletion != nil {
            var findedCameraRoll = false
            smartAlbums.enumerateObjects { obj, _, stop in
                if !obj.isKind(of: PHAssetCollection.self) {
                    return
                }
                if self.checkValidAssetCollection(collection: obj) == false {
                    return
                }
                if self.isCameraRollAlbum(collection: obj) {
                    let fetchResult = PHAsset.fetchAssets(in: obj, options: fetchOptions)
                    let collectionModel = AlbumModel(collection: obj, result: fetchResult)
                    collectionModel.isCameraRoll = true
                    cameraRollCompletion?(collectionModel)
                    findedCameraRoll = true
                    stop.pointee = true
                }
            }
            if findedCameraRoll == false {
                cameraRollCompletion?(nil)
            }
        }
        self.getCameraRoolOtherAlbumsWithType(fetchOptions: fetchOptions, smartAlbums: smartAlbums, completion: otherCompletion)
    }
    
    func getCameraRoolOtherAlbumsWithType(fetchOptions: PHFetchOptions?, smartAlbums:PHFetchResult<PHAssetCollection>, completion: @escaping ([AlbumModel]?, Error?) -> Void) {
        let myPhotoStreamAlbum = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumMyPhotoStream, options: nil)
        let syncedAlbums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumSyncedAlbum, options: nil)
        let sharedAlbums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumCloudShared, options: nil)
        var allAlbums : [PHFetchResult<PHAssetCollection>] = [myPhotoStreamAlbum,syncedAlbums,sharedAlbums,smartAlbums]
        let topLevelUserCollections = PHAssetCollection.fetchTopLevelUserCollections(with: nil)
        allAlbums.append(contentsOf: self.p_retrieveColllectionsInCollectionList(topLevelUserCollections))
        var collectionModelArray : [AlbumModel] = []
        for album in allAlbums {
            album.enumerateObjects {[weak self] assetCollection, _, _ in
                guard let self = self else {
                    return
                }
                if !assetCollection.isKind(of: PHAssetCollection.self) {
                    return
                }
                if self.isCameraRollAlbum(collection: assetCollection) {
                    return
                }
                if self.checkValidAssetCollection(collection: assetCollection) == false {
                    return
                }
                let result = PHAsset.fetchAssets(in: assetCollection, options: fetchOptions)
                if result.count < 1 {
                    return
                }
                let collectionModel = AlbumModel(collection: assetCollection, result: result)
                collectionModelArray.append(collectionModel)
            }
        }
        completion(collectionModelArray, nil)
    }
    
    func getResultFromCollection(collection: AlbumModel,
                                          type: AlbumMediaType?,
                                          isFavorite: Bool,
                                          completion: @escaping (PHFetchResult<PHAsset>) -> Void) {
        let fetchOptions : PHFetchOptions = PHFetchOptions()
        var formatString = ""
        switch type {
        case .video:
            formatString += "mediaType == \(PHAssetMediaType.video.rawValue)"
        case .photo:
            formatString += "mediaType == \(PHAssetMediaType.image.rawValue)"
        case .none:
            break
        }
        if isFavorite == true {
            if !formatString.isEmpty {
                formatString += " AND "
            }
            formatString += "favorite == 1"
        }
        fetchOptions.predicate = NSPredicate(format: formatString, argumentArray: nil)
        let result = PHAsset.fetchAssets(in: collection.collection, options: fetchOptions)
        completion(result)
    }
    
    private func checkValidAssetCollection(collection : PHAssetCollection) -> Bool {
        if collection.assetCollectionSubtype == .smartAlbumAllHidden {
            return false
        }
        if (collection.estimatedAssetCount <= 0) && (isCameraRollAlbum(collection: collection) == false) {
            return false
        }
        return true
    }
    
    private func isCameraRollAlbum(collection: PHAssetCollection) -> Bool {
        return collection.assetCollectionSubtype == .smartAlbumUserLibrary
    }
    
    private func p_retrieveColllectionsInCollectionList(_ fetchedCollection: PHFetchResult<PHCollection>) -> [PHFetchResult<PHAssetCollection>] {
        var assetCollectionArray : [PHFetchResult<PHAssetCollection>] = []
        fetchedCollection.enumerateObjects { collection, _, _ in
            if let collectionList = collection as? PHCollectionList {
                if let result = PHAssetCollection.fetchCollections(in: collectionList, options: nil) as? PHFetchResult<PHAssetCollection> {
                    assetCollectionArray.append(result)
                }
            }
        }
        return assetCollectionArray
    }
}

extension RequestManager {
    public func getUIImageWithPHAsset(asset: PHAsset, imageSize: CGSize, contentMode: PHImageContentMode, networkAccessAllowed: Bool, resizeMode : PHImageRequestOptionsResizeMode, iCloudBlock : @escaping () -> Void, progressHandler: @escaping PHAssetImageProgressHandler, completion: @escaping(UIImage?, [AnyHashable : Any]?, Bool) -> Void) -> PHImageRequestID {
        let option = PHImageRequestOptions()
        option.resizeMode = resizeMode
        if #available(iOS 14, *) {
            option.version = PHImageRequestOptionsVersion.current
        }
        let requestID = RequestManager.cachingImageManager.requestImage(for: asset, targetSize: imageSize, contentMode: contentMode, options: option) { resultImage, dict in
            let isDegraded = dict?[PHImageResultIsDegradedKey] as? Bool ?? false
            
            let error = dict?[PHImageErrorKey] as? Error
            let isICloud = dict?[PHImageResultIsInCloudKey] as? Bool ?? false
            if isICloud && resultImage == nil && networkAccessAllowed {
                iCloudBlock()
                self.getUIImageFromICloudWithPHAsset(asset: asset, imageSize: imageSize, contentMode: contentMode, resizeMode: resizeMode, progressHandler: progressHandler, completion: completion)
                return
            }
            let isCancelled = dict?[PHImageCancelledKey] as? Bool ?? false
            if error == nil && isCancelled == false {
                completion(resultImage, dict, isDegraded)
            } else {
                completion(nil, dict, isDegraded)
            }
        }
        return requestID
    }
    
    func getUIImageFromICloudWithPHAsset(asset:PHAsset,
                                         imageSize: CGSize,
                                         contentMode: PHImageContentMode,
                                         resizeMode: PHImageRequestOptionsResizeMode,
                                         progressHandler: @escaping PHAssetImageProgressHandler,
                                         completion:@escaping(UIImage?, [AnyHashable : Any]?, Bool) -> Void) {
        let option  = PHImageRequestOptions()
        if #available(iOS 14, *) {
            option.version = PHImageRequestOptionsVersion.current
        }
        option.progressHandler = { progress, error, stop, dict in
            DispatchQueue.main.async {
                progressHandler(progress, error, stop, dict)
            }
        }
        option.isNetworkAccessAllowed = true
        option.resizeMode = resizeMode
        DispatchQueue.global().async {
            if #available(iOS 13, *) {
                RequestManager.cachingImageManager.requestImageDataAndOrientation(for: asset, options: option) { imageData, _, _, dict in
                    let isDegraded = dict?[PHImageResultIsDegradedKey] as? Bool ?? false
                    if isDegraded {
                        return
                    }
                    DispatchQueue.main.async {
                        if let imageData {
                            let resultImage = UIImage(data: imageData)
                            completion(resultImage, dict, false)
                        } else {
                            completion(nil, dict, false)
                        }
                    }
                }
            } else {
                RequestManager.cachingImageManager.requestImage(for: asset, targetSize: imageSize, contentMode: contentMode, options: option) { image, dict in
                    let isDegraded = dict?[PHImageResultIsDegradedKey] as? Bool ?? false
                    if isDegraded {
                        return
                    }
                    DispatchQueue.main.async {
                        completion(image, dict, false)
                    }
                }
            }
        }
    }
}
