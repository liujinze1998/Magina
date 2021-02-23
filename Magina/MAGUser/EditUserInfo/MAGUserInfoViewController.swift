//
//  MAGUserInfoViewController.swift
//  Magina
//
//  Created by liujinze on 2021/2/22.
//

import UIKit

class MAGUserInfoViewController: UIViewController
{
    var descriptionTextArray:[String] = ["头像", "昵称", "性别", "Magina号", "个性签名"]
    var contentArray:[String] = ["四环影魔王", "男", "7588SFKing", "你技术真差"] //todo持久化
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.reloadData()
    }
    
    
    func configNavigation() {
        self.navigationItem.title = "个人信息"
    }
}

//tableView Delegate

extension MAGUserInfoViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return descriptionTextArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellid = "ReusableCellID"
        if indexPath.row == 0 {
            var cell:MAGUserInfoAvatarTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellid) as? MAGUserInfoAvatarTableViewCell
            if cell == nil {
                cell = MAGUserInfoAvatarTableViewCell(style: .subtitle, reuseIdentifier: cellid)
            }
            
            cell?.leftLabel.text = descriptionTextArray[indexPath.row]
            cell?.rightAvatar.image = UIImage(named:"touxiang")
            return cell!
        } else {
            var cell:MAGUserInfoTextTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellid) as? MAGUserInfoTextTableViewCell
            if cell == nil {
                cell = MAGUserInfoTextTableViewCell(style: .subtitle, reuseIdentifier: cellid)
            }
            
            cell?.leftLabel.text = descriptionTextArray[indexPath.row]
            cell?.rightLabel.text = contentArray[indexPath.row - 1]
            return cell!
        }
    }
    
    //点击cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("选中了第几个cell: \(indexPath.row + 1)")
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            //和换bgimage一样 点击换头像
            break
        case 1:
            //alert 换名字
//            let vc = NibCellController()
//            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 2:
            //alert选性别
            break
        case 3:
            //alert编辑magina号
            break
        case 4:
            //alert编辑个性签名
            break
        default:
            break
        }
    }
}
