//
//  AlbumNavigationView.swift
//  Magina
//
//  Created by AM on 2024/3/7.
//

import Foundation
import UIKit

class AlbumNavigationBar : UIView {
    public var titleButton : UIButton?
    public var closeButton : UIButton?
    public var reverseButton : UIButton?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        let labelFrame = CGRect(origin: CGPoint(x: (frame.width - 300)/2, y: 50), size: CGSize(width: 300, height: 80))
        titleButton = UIButton(frame: labelFrame)
        titleButton!.setTitle("相册名", for: .normal)
        titleButton!.backgroundColor = UIColor.clear
        titleButton!.setTitleColor(UIColor.black, for: .normal)
        titleButton!.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(titleButton!)
        
        let closeFrame = CGRect(origin: CGPoint(x: 10, y: 50), size: CGSize(width: 80, height: 80))
        closeButton = UIButton(frame: closeFrame)
        closeButton!.setTitle("关闭", for: .normal)
        closeButton!.backgroundColor = UIColor.clear
        closeButton!.setTitleColor(UIColor.black, for: .normal)
        closeButton!.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(closeButton!)
        
        let reverseFrame = CGRect(origin: CGPoint(x: frame.width - 90, y: 50), size: CGSize(width: 80, height: 80))
        reverseButton = UIButton(frame: reverseFrame)
        reverseButton!.setTitle("倒序", for: .normal)
        reverseButton!.backgroundColor = UIColor.clear
        reverseButton!.setTitleColor(UIColor.black, for: .normal)
        self.addSubview(reverseButton!)
    }
}
