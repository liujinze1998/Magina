//
//  MediaContainer.swift
//  Magina
//
//  Created by AM on 2024/3/7.
//

import Foundation
import Photos

protocol ContainerSourceChangeSubscriber : AnyObject {
    var registerID : String { get }
    func receiveSourceChange(_ diff: PHFetchResultChangeDetails<PHAsset>?, newValue : PHFetchResult<PHAsset>)
}

public class CategoryDataSource : NSObject {
    var categoryID : String
    public var count : Int {
        return originFetchResult?.count ?? 0
    }
    
    private var originFetchResult : PHFetchResult<PHAsset>?
    var subscribers : [any ContainerSourceChangeSubscriber] = []
    public private(set) var reversed = false
    
    init(categoryID: String, result: PHFetchResult<PHAsset>?) {
        self.categoryID = categoryID
        self.originFetchResult = result
        
    }
    
    func addSubscriber(_ subsciber: ContainerSourceChangeSubscriber) {
        subscribers.append(subsciber)
    }
    
    func removeSubscriber(_ subsciber: ContainerSourceChangeSubscriber) {
        let index = subscribers.firstIndex { item in
            item.registerID == subsciber.registerID
        }
        if let removeIndex = index {
            subscribers.remove(at: removeIndex)
        }
    }
    
    public func notifySubscriber(diff: PHFetchResultChangeDetails<PHAsset>?, newValue : PHFetchResult<PHAsset>) {
        for subscriber in subscribers {
            subscriber.receiveSourceChange(diff, newValue: newValue)
        }
    }
}

extension CategoryDataSource {
    public func cellModelAtIndex(index : Int) -> PHAsset? {
        if index >= count || index < 0 {
            return nil
        }
        var mediaIndex = index
        if reversed {
            mediaIndex = count - (index + 1)
        }
        guard let asset = originFetchResult?.object(at: mediaIndex) else {
            return nil
        }
        return asset
    }
}

extension CategoryDataSource {
    func applyMediaDiff(diff: PHFetchResultChangeDetails<PHAsset>, newValue : PHFetchResult<PHAsset>) {
        originFetchResult = newValue
        notifySubscriber(diff: diff, newValue: newValue)
    }
    
    internal func updateFetchResult(_ newValue:PHFetchResult<PHAsset>) {
        originFetchResult = newValue
        notifySubscriber(diff: nil, newValue: newValue)
    }
    
    public func reverse() {
        self.reversed = !reversed
    }
}

