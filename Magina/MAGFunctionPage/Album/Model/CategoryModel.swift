//
//  CategoryModel.swift
//  Magina
//
//  Created by AM on 2024/3/7.
//

import UIKit

struct CategoryModel{
    var type : AlbumMediaType?
    public private(set) var name : String
    var isFavorite : Bool = false
    public init(type: AlbumMediaType? = nil, name: String) {
        self.type = type
        self.name = name
    }
    public init(type: AlbumMediaType? = nil, isFavorite: Bool, name: String) {
        self.type = type
        self.isFavorite = isFavorite
        self.name = name
    }
}

@objc(MAGAlbumFactory)
class AlbumFactory: NSObject {
    @objc func openRegularAlbum(parentVC: UIViewController) {
        let navVC = UINavigationController(rootViewController: AlbumMainViewController(categoryModels: descriptionOfCategory()))
        navVC.modalPresentationStyle = .fullScreen
        parentVC.present(navVC, animated: true, completion: nil)
    }
    
    func descriptionOfCategory() -> [CategoryModel] {
        let allMediaCategoryContext = CategoryModel(type: nil, name: "all")
        let videoMediaCategoryContext = CategoryModel(type: AlbumMediaType.video, name: "videos")
        let photoMediaCategoryContext = CategoryModel(type: AlbumMediaType.photo, name: "photos")
        let favoriteMediaCategoryContext = CategoryModel(isFavorite: true, name: "collect")
        return [allMediaCategoryContext,videoMediaCategoryContext,photoMediaCategoryContext,favoriteMediaCategoryContext]
    }
}
