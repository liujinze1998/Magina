//
//  File.swift
//  
//
//  Created by AM on 2024/3/7.
//

import Foundation
import Photos
import UIKit

public class AlbumModel: NSObject {
    public var name : String?
    public var count : Int {
        return fetchResult?.count ?? 0
    }
    public var localIdentifier : String
    var fetchResult : PHFetchResult<PHAsset>?
    var collection : PHAssetCollection
    public var isCameraRoll : Bool = false
    public init(collection: PHAssetCollection, result: PHFetchResult<PHAsset>?) {
        self.collection = collection
        self.name = collection.localizedTitle
        self.localIdentifier = collection.localIdentifier
        self.fetchResult = result
    }
    
    func loadFetchResultIfNeeded() {
        if fetchResult != nil {
            return
        }
        let result = PHAsset.fetchAssets(in: collection, options: nil)
        self.fetchResult = result
    }
    
    public func update(result: PHFetchResult<PHAsset>) {
        self.fetchResult = result
    }
    
    public func getCoverImage(imageSize: CGSize, contentMode: PHImageContentMode, networkAccessAllowed: Bool, resizeMode : PHImageRequestOptionsResizeMode, completion: @escaping(UIImage?, [AnyHashable : Any]?, _ isDegraded: Bool) -> Void) {
        guard let coverAsset = fetchResult?.firstObject else {
            completion(nil, nil, false)
            return
        }
        let requestID = RequestManager.shared.getUIImageWithPHAsset(asset: coverAsset, imageSize: imageSize, contentMode: contentMode, networkAccessAllowed: networkAccessAllowed, resizeMode: resizeMode) {
            //icloud
        } progressHandler: { _, _, _, _ in
            //progress
        } completion: { resultImage, dict, isDegraded in
            completion(resultImage, dict, isDegraded)
        }
        print(requestID)
    }
}
