//
//  AlbumMediaCell.swift
//  Magina
//
//  Created by AM on 2024/3/7.
//

import Foundation
import UIKit
import Photos

class AlbumMediaCell: UICollectionViewCell {
    lazy var coverImageView : UIImageView = {
        let view = UIImageView(frame: contentView.bounds)
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var videoDurationLabel : UILabel = {
        let label = UILabel(frame: CGRect(x: contentView.bounds.width - 62, y: contentView.bounds.height - 17, width: 60, height: 15))
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.shadowOffset = CGSize(width: 0, height: 1)
        label.shadowColor = UIColor.black.withAlphaComponent(0.15)
        label.textAlignment = NSTextAlignment.right
        label.font = UIFont.systemFont(ofSize: 12 ,weight: .medium)
        return label
    }()
    
    
    lazy var customContent : UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 5, width: contentView.bounds.width, height: 50))
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.white
        label.shadowOffset = CGSize(width: 0, height: 1)
        label.shadowColor = UIColor.black.withAlphaComponent(0.15)
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 15 ,weight: .medium)
        return label
    }()
    
    //selected
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(coverImageView)
        contentView.addSubview(videoDurationLabel)// if needed
        contentView.addSubview(customContent)//if needed
        self.coverImageView.backgroundColor = UIColor.white
        self.backgroundColor = UIColor.red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coverImageView.image = nil
        videoDurationLabel.text = nil
    }
}

extension AlbumMediaCell {
    func configWithAsset(_ asset: PHAsset?) {
        guard let existAsset = asset else {
            return
        }
        let scale: CGFloat = UIScreen.main.scale
        let targetSize = CGSize(width: 72 * scale, height: 72 * scale)
        RequestManager.shared.getUIImageWithPHAsset(asset: existAsset, imageSize: targetSize, contentMode: .aspectFill, networkAccessAllowed: false, resizeMode: .fast) {
            //icloud do nothing
        } progressHandler: { progress, error, stop, dict in
            //progress do nothing
        } completion: { resultImage, dict, isDegraded in
            self.coverImageView.image = resultImage
        }
        
        videoDurationLabel.isHidden = true
        customContent.isHidden = true
        if existAsset.mediaType == .video {
            videoDurationLabel.isHidden = false
            let seconds = round(existAsset.duration)
            let second = seconds.truncatingRemainder(dividingBy: 60)
            let minute = seconds / 60;
            let videoDuration = String(format: "%02d:%02d", Int(minute) , Int(second))
            videoDurationLabel.text = videoDuration
        } else {
            //more custom UI
        }
    }
}

