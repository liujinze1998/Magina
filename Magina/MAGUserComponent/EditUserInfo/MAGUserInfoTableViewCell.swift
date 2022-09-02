//
//  MAGUserInfoTableViewCell.swift
//  Magina
//
//  Created by liujinze on 2021/2/22.
//

import UIKit

//普通文本cell
class MAGUserInfoTextTableViewCell: UITableViewCell {

    let width:CGFloat = UIScreen.main.bounds.width
    var leftLabel:UILabel!
    var rightLabel:UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        leftLabel = UILabel(frame: CGRect(x: 20, y: 10, width: 100, height: 40))
        leftLabel.textAlignment = .left
        leftLabel.textColor = UIColor.black
        leftLabel.font = UIFont.systemFont(ofSize: 20)
        
        
        rightLabel = UILabel(frame: CGRect(x: width - 220, y: 10, width: 200, height: 40))
        rightLabel.textAlignment = .right
        rightLabel.textColor = UIColor.gray
        rightLabel.font = UIFont.systemFont(ofSize: 15)
        
        contentView.addSubview(leftLabel)
        contentView.addSubview(rightLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

//头像cell
class MAGUserInfoAvatarTableViewCell: UITableViewCell {

    let width:CGFloat = UIScreen.main.bounds.width
    var leftLabel:UILabel!
    var rightAvatar:UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        leftLabel = UILabel(frame: CGRect(x: 20, y: 10, width: 100, height: 40))
        leftLabel.textAlignment = .left
        leftLabel.textColor = UIColor.black
        leftLabel.font = UIFont.systemFont(ofSize: 20)
        
        rightAvatar = UIImageView(frame: CGRect(x: width - 70, y: 5, width: 50, height: 50))
        rightAvatar.layer.masksToBounds = true
        rightAvatar.layer.cornerRadius = 22.0
        
        contentView.addSubview(leftLabel)
        contentView.addSubview(rightAvatar)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
