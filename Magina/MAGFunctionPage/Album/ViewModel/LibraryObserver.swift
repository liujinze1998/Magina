//
//  File.swift
//  
//
//  Created by AM on 2024/3/7.
//

import Foundation
import Photos
import UIKit

protocol LibraryChangeConsumer : AnyObject {
    func applyLibraryGlobalChange(_ change : PHChange)
    
    func applyLibraryCategoryChange(details :[String:PHFetchResultChangeDetails<PHAsset>])
}

class LibraryObserver : NSObject {
    public weak var consumer : LibraryChangeConsumer?
    
    var globalFetchResult: PHFetchResult<PHAsset>?
    private var categoryFetchResultDict : [String : PHFetchResult<PHAsset>] = [:]
    private var dictLock : pthread_mutex_t
    
    private var isBackground : Bool = false
    private var temporaryChangeInstances : [PHChange] = []
    private let notifyQueue : DispatchQueue
    
    init(fetchResult: PHFetchResult<PHAsset>?) {
        self.globalFetchResult = fetchResult
        self.notifyQueue = DispatchQueue(label: "com.Magina.libraryChangeNotify.queue")
        
        self.dictLock = pthread_mutex_t()
        var attr = pthread_mutexattr_t()
        pthread_mutexattr_init(&attr)
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE)
        pthread_mutex_init(&dictLock, &attr)
        super.init()
        self.addSystemObserve()
    }
    
    func addCategoryDictSource(_ id:String, result:PHFetchResult<PHAsset>?) {
        guard let result else {
            return
        }
        pthread_mutex_lock(&dictLock)
        categoryFetchResultDict[id] = result
        pthread_mutex_unlock(&dictLock)
    }
    
    func addSystemObserve() {
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    deinit {
        pthread_mutex_destroy(&dictLock)
        NotificationCenter.default.removeObserver(self)
    }
}

extension LibraryObserver {
    @objc func didBecomeActive(noti: Notification) {
        isBackground = false
        if !temporaryChangeInstances.isEmpty {
            notifyQueue.async {
                for changeInstance in self.temporaryChangeInstances {
                    self.notifyWithChange(changeInstance)
                }
                self.temporaryChangeInstances.removeAll()
            }
        }
    }
    
    @objc func didEnterBackground(noti: Notification) {
        isBackground = true
    }
}

extension LibraryObserver: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        notifyQueue.async {
            if self.isBackground {
                self.temporaryChangeInstances.append(changeInstance)
            } else {
                self.notifyWithChange(changeInstance)
            }
        }
    }
    
    private func notifyWithChange(_ changeInstance: PHChange) {
        //notify single result
        if let globalFetchResult, let change = changeInstance.changeDetails(for: globalFetchResult) {
            self.consumer?.applyLibraryGlobalChange(changeInstance)
            self.globalFetchResult = change.fetchResultAfterChanges
        }
        //notify multi results
        if categoryFetchResultDict.isEmpty {
            return
        }
        var changeResults : [String:PHFetchResultChangeDetails<PHAsset>] = [:]
        pthread_mutex_lock(&dictLock)
        let dict = categoryFetchResultDict
        pthread_mutex_unlock(&dictLock)
        for (categoryID, result) in dict {
            if let change = changeInstance.changeDetails(for: result) {
                changeResults[categoryID] = change
                pthread_mutex_lock(&dictLock)
                categoryFetchResultDict[categoryID] = change.fetchResultAfterChanges
                pthread_mutex_unlock(&dictLock)
            }
        }
        self.consumer?.applyLibraryCategoryChange(details: changeResults)
    }
}

extension LibraryObserver {
    class ObserverToken {
        let observer: PHPhotoLibraryChangeObserver
        let library: PHPhotoLibrary
        deinit {
            let library = self.library
            let observer = self.observer
            if Thread.isMainThread {
                library.unregisterChangeObserver(observer)
            } else {
                DispatchQueue.main.async {
                    library.unregisterChangeObserver(observer)
                }
            }
        }
        
        init(observer: PHPhotoLibraryChangeObserver, library: PHPhotoLibrary) {
            self.observer = observer
            self.library = library
        }
    }
    
    func attatch(to library: PHPhotoLibrary) -> AnyObject {
        library.register(self)
        return ObserverToken(observer: self, library: library)
    }
}
