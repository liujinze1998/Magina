//
//  SlidingTabView.swift
//  Magina
//
//  Created by AM on 2024/3/7.
//

import Foundation
import UIKit

class AlbumSlidingTabView: UIView {
    var buttonsArray: [UIButton] = []
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        return view
    }()
    
    weak var slidingVC: AlbumSlidingViewController?
    var selectedIndex: Int {
        didSet(value) {
            for (index,button) in buttonsArray.enumerated() {
                button.isSelected = (index == selectedIndex)
            }
            updateLineFrame()
        }
    }
    
    private var buttonWidth: Int {
        return (Int(self.bounds.width) - 20 - (buttonsArray.count - 1) * 10) / buttonsArray.count
    }
    
    init(frame: CGRect, titles: [String],defalutIndex: Int) {
        selectedIndex = defalutIndex
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGray
        self.setupButtonWithTitles(titles: titles)
        self.configButtonsFrame()
        self.setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButtonWithTitles(titles: [String]) {
        if titles.isEmpty {
            return
        }
        var buttons : [UIButton] = []
        for (index,title) in titles.enumerated() {
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.isSelected = (index == selectedIndex)
            button.backgroundColor = UIColor.clear
            button.setTitleColor(UIColor.darkGray, for: .normal)
            button.setTitleColor(UIColor.black, for: .selected)
            button.tag = index + 10001
            buttons.append(button)
        }
        buttonsArray = buttons
    }
    
    func configButtonsFrame(){
        var originX = 10
        for button in buttonsArray {
            let frame = CGRect(x: originX, y: 1, width: buttonWidth, height: Int(self.bounds.height - 3))
            button.frame = frame
            originX += buttonWidth + 10
        }
    }
    
    func setupSubviews(){
        if buttonsArray.isEmpty {
            return
        }
        for button in buttonsArray {
            self.addSubview(button)
            button.addTarget(self, action: #selector(buttonClick(sender: )), for: .touchUpInside)
        }
        
        let x = 10 + selectedIndex * (buttonWidth + 10)
        lineView.frame = CGRect(x: x, y: Int(buttonsArray.first!.bounds.height+1), width: (buttonWidth-2), height: 2)
        self.addSubview(lineView)
    }
    
    func updateLineFrame(){
        let x = 10 + selectedIndex * (buttonWidth + 10)
        let newLineFrame = CGRect(x: x, y: Int(buttonsArray.first!.bounds.height+1), width: (buttonWidth-2), height: 2)
        UIView.animate(withDuration: 0.15) {
            self.lineView.frame = newLineFrame
        }
    }
    
    @objc func buttonClick(sender: UIButton){
        selectedIndex = sender.tag - 10001
        slidingVC?.selectedIndex = selectedIndex
    }
}
