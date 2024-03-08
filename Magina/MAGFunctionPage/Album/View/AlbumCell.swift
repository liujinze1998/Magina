//
//  AlbumCell.swift
//  Magina
//
//  Created by AM on 2024/3/7.
//

import Foundation
import UIKit

class AlbumCell : UITableViewCell{
    lazy var titleLabel : UILabel = {
        let label = UILabel(frame: CGRect(x: 88, y: 14, width: self.bounds.size.width - 96, height: 18))
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    lazy var subTitleLabel : UILabel = {
        let label = UILabel(frame: CGRect(x: 88, y: 50, width: self.bounds.size.width - 96, height: 16))
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    lazy var coverImageView : UIImageView = {
        let view = UIImageView(frame: CGRect(x: 8, y: 4, width: 72, height: 72))
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.addSubview(coverImageView)
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coverImageView.image = nil
        titleLabel.text = nil
        subTitleLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configWithModel(_ model: AlbumModel?) {
        coverImageView.backgroundColor = UIColor.black
        titleLabel.text = model?.name
        let number = (model?.count)! as NSNumber
        subTitleLabel.text = number.stringValue
        
        let scale: CGFloat = UIScreen.main.scale
        let targetSize = CGSize(width: 72 * scale, height: 72 * scale)
        model?.getCoverImage(imageSize: targetSize, contentMode: .aspectFill, networkAccessAllowed: false, resizeMode: .fast, completion: { [weak self] image, dict, isDegraded in
            DispatchQueue.main.async {
                self?.coverImageView.image = image
            }
        })
    }
}
