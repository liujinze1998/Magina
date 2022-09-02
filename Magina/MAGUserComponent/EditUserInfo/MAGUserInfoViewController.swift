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
    var tableView : UITableView = UITableView()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.reloadData()
        configNavigation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func configNavigation() {
        self.navigationItem.title = "个人信息"
        self.tabBarController?.tabBar.isHidden = true
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
            cell?.rightAvatar.image = UIImage(named:"touxiang")//todo 从持久化里取
            return cell!
        } else {
            var cell:MAGUserInfoTextTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellid) as? MAGUserInfoTextTableViewCell
            if cell == nil {
                cell = MAGUserInfoTextTableViewCell(style: .subtitle, reuseIdentifier: cellid)
            }
            
            cell?.leftLabel.text = descriptionTextArray[indexPath.row]
            cell?.rightLabel.text = getStringForRow(row: indexPath.row)
            return cell!
        }
    }
    
    func getStringForRow(row : Int) -> String {
        switch row {
        case 1:
            return MAGUserDefaultsUtil.userName
        case 2:
            return MAGUserDefaultsUtil.sex
        case 3:
            return MAGUserDefaultsUtil.maginaNum
        case 4:
            return MAGUserDefaultsUtil.signature
        default:
            return ""
        }
    }
    
    //点击cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("选中了第几个cell: \(indexPath.row + 1)")
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            handleClickedForChangeAvatar()
            break
        case 1:
            handleClickedForChangeName()
            break
        case 2:
            handleClickedForChangeSex()
            break
        case 3:
            handleClickedForChangeMAGNum()
            break
        case 4:
            handleClickedForChangeText()
            break
        default:
            break
        }
    }
}

extension MAGUserInfoViewController : MAGImagePickerDelegate
{
    func didFinishPicking(_ image: UIImage?) {
        //todo 修改持久化信息的image
        self.tableView.reloadData()
    }
    
    func handleClickedForChangeAvatar() {
        let alertController = UIAlertController(title: "更换头像", message:nil, preferredStyle: UIAlertController.Style.actionSheet)
        let tackPicture = UIAlertAction(title: "相机拍摄", style: UIAlertAction.Style.default) { (UIAlertAction) in
            let imagePickerManager : MAGCaptureAlbumManager = MAGCaptureAlbumManager.shared()
            imagePickerManager.delegate = self
            imagePickerManager.replaceImageFromCapture(withCurrentController: self)
        }
        let choosePickture = UIAlertAction(title: "相册选择", style: UIAlertAction.Style.default) { (UIAlertAction) in
            let imagePickerManager : MAGCaptureAlbumManager = MAGCaptureAlbumManager.shared()
            imagePickerManager.delegate = self
            imagePickerManager.replaceImageFromAlbum(withCurrentController: self)
        }
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(tackPicture)
        alertController.addAction(choosePickture)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func handleClickedForChangeName() {
        let alertController = UIAlertController(title: "更换用户昵称", message: nil, preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField(configurationHandler: { (textField: UITextField!) -> Void in
            textField.placeholder = "输入新昵称"
            NotificationCenter.default.addObserver(self, selector: #selector(self.alertTextFieldDidChange(notification:)), name: UITextField.textDidChangeNotification, object: textField)
        })
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel, handler: nil)
        let finishAction = UIAlertAction(title: "完成", style: UIAlertAction.Style.default , handler: { (action: UIAlertAction!) -> Void in
            let newNameStr = (alertController.textFields?.first)! as UITextField
            print("新的name: \(newNameStr)")
            MAGUserDefaultsUtil.userName = newNameStr.text ?? ""
            self.tableView.reloadData()
            NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: nil)
        })
        finishAction.isEnabled = false
        alertController.addAction(cancelAction)
        alertController.addAction(finishAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func handleClickedForChangeSex() {
        //alert选性别
        let alertController = UIAlertController(title: "更换性别", message:nil, preferredStyle: UIAlertController.Style.alert)
        let tackPicture = UIAlertAction(title: "男", style: UIAlertAction.Style.default) { (UIAlertAction) in
            MAGUserDefaultsUtil.sex = "男"
            self.tableView.reloadData()
        }
        let choosePickture = UIAlertAction(title: "女", style: UIAlertAction.Style.default) { (UIAlertAction) in
            MAGUserDefaultsUtil.sex = "女"
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(tackPicture)
        alertController.addAction(choosePickture)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func handleClickedForChangeMAGNum() {
        let alertController = UIAlertController(title: "更换Magina号", message: nil, preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField(configurationHandler: { (textField: UITextField!) -> Void in
            textField.placeholder = "输入新的Magina号"
            NotificationCenter.default.addObserver(self, selector: #selector(self.alertTextFieldDidChange(notification:)), name: UITextField.textDidChangeNotification, object: textField)
        })
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel, handler: nil)
        let finishAction = UIAlertAction(title: "完成", style: UIAlertAction.Style.default , handler: { (action: UIAlertAction!) -> Void in
            let newMaginaStr = (alertController.textFields?.first)! as UITextField
            MAGUserDefaultsUtil.maginaNum = newMaginaStr.text ?? ""
            self.tableView.reloadData()
            NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: nil)
        })
        finishAction.isEnabled = false
        alertController.addAction(cancelAction)
        alertController.addAction(finishAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func handleClickedForChangeText() {
        let alertController = UIAlertController(title: "更换个性签名", message: nil, preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField(configurationHandler: { (textField: UITextField!) -> Void in
            textField.placeholder = "在此输入新的个性签名"
            NotificationCenter.default.addObserver(self, selector: #selector(self.alertTextFieldDidChange(notification:)), name: UITextField.textDidChangeNotification, object: textField)
        })
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel, handler: nil)
        let finishAction = UIAlertAction(title: "完成", style: UIAlertAction.Style.default , handler: { (action: UIAlertAction!) -> Void in
            let newTextStr = (alertController.textFields?.first)! as UITextField
            MAGUserDefaultsUtil.signature = newTextStr.text ?? ""
            self.tableView.reloadData()
            NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: nil)
        })
        finishAction.isEnabled = false
        alertController.addAction(cancelAction)
        alertController.addAction(finishAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func alertTextFieldDidChange(notification: NSNotification){
        let alertController = self.presentedViewController as! UIAlertController?
        if (alertController != nil) {
            let newName = (alertController!.textFields?.first)! as UITextField
            let finishAction = alertController!.actions.last! as UIAlertAction
            if (newName.text?.lengthOfBytes(using: String.Encoding.utf8))! > 6 {
                finishAction.isEnabled = true
            } else {
                finishAction.isEnabled = false
            }
        }
    }
}

