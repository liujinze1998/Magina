//
//  AlbumMainViewController.swift
//  Magina
//
//  Created by AM on 2024/3/8.
//

import Foundation
import UIKit

let AlbumRootNavHeight : CGFloat = 140

class AlbumMainViewController : UIViewController{
    var viewModel: AlbumViewModel
    var slidingViewController: AlbumSlidingViewController
    var albumMenuTableView: UITableView?
    var navigationView: AlbumNavigationBar?
    var slidingTabView : AlbumSlidingTabView?
    var searchButton : UIButton?
    
    lazy var wrapperView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 140, width: view.bounds.width, height: view.bounds.height - AlbumRootNavHeight))
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    init(categoryModels: [CategoryModel]) {
        self.viewModel = AlbumViewModel(categoryModels: categoryModels)
        var titles : [String] = []
        var categortVCs : [AlbumCategoryViewController] = []
        for context in viewModel.dataInfo {
            titles.append(context.name)
            let category = AlbumCategoryViewController(viewModel: viewModel, categoryID: context.name)
            categortVCs.append(category)
        }
        self.slidingViewController = AlbumSlidingViewController(titles: titles, selectedIndex: 0)
        for vc in categortVCs {
            slidingViewController.addViewController(vc: vc)
        }
        super.init(nibName: nil, bundle: nil)
        
        viewModel.albumInitBlock = { [weak self] in
            self?.updateTitle(self?.viewModel.data?.currentCollectionModel?.name)
            self?.albumMenuTableView?.reloadData()
        }
        viewModel.globalDataReadyBlock = { result in
            print("album global data ready")
        }
        viewModel.categoryDataFetchCompletion = { [weak self] categoryID, container in
            self?.slidingViewController.reloadViewControllerWith(id: categoryID, container: container)
        }
        viewModel.startFetch()
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = AlbumViewModel(categoryModels: AlbumFactory().descriptionOfCategory())
        self.slidingViewController = AlbumSlidingViewController(titles: [], selectedIndex: 0)
        super.init(coder: coder)
        self.navigationController?.navigationBar.isHidden = true;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupSlidingVC()
        self.navigationController?.navigationBar.isHidden = true;
    }
}


extension AlbumMainViewController {
    func setupSlidingVC(){
        view.addSubview(wrapperView)
        slidingViewController.view.frame = self.slidingVCFrame()
        wrapperView.addSubview(slidingViewController.view)
        if viewModel.dataInfo.isEmpty == false {
            let tabFrame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 40)
            slidingTabView = AlbumSlidingTabView(frame: tabFrame, titles: slidingViewController.titles, defalutIndex: 0)
            wrapperView.addSubview(slidingTabView!)
            slidingTabView?.slidingVC = slidingViewController
            slidingViewController.slidingTab = slidingTabView
        }
        slidingViewController.updateCategoryVCFrame()
        self.addChild(slidingViewController)
        slidingViewController.didMove(toParent: self)
    }
    
    func slidingVCFrame() -> CGRect{
        var y = 0
        var heightOffset = AlbumRootNavHeight
        if !viewModel.dataInfo.isEmpty {
            y = y + 40
            heightOffset = heightOffset + 40
        }

        let rect = CGRect(origin: CGPoint(x: 0, y: y), size: CGSize(width: view.frame.size.width - 2, height: view.frame.size.height - heightOffset))
        return rect
    }
    
    func setupNav() {
        navigationView = AlbumNavigationBar(frame: CGRect(origin: CGPointZero, size: CGSize(width: self.view.frame.width, height: AlbumRootNavHeight)))
        view.addSubview(navigationView!)
        navigationView!.closeButton!.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        navigationView!.reverseButton!.addTarget(self, action: #selector(reverseData), for: .touchUpInside)
        navigationView!.titleButton!.addTarget(self, action: #selector(clickTitleButton), for: .touchUpInside)
        self.updateTitle(self.viewModel.data?.currentCollectionModel?.name)
    }
    
    @objc func closeVC() {
        self.navigationController?.dismiss(animated: true)
    }
    
    @objc func reverseData() {
        viewModel.reverseData = !viewModel.reverseData
        slidingViewController.reverseDataSource()
    }
    
    @objc func clickTitleButton() {
        if albumMenuTableView != nil {
            dimissAlbumMenu()
        } else {
            showAlbumMenu()
        }
    }
    
    func showAlbumMenu() {
        let rect = CGRect(origin: CGPoint(x: 0, y: 140), size: CGSize(width: view.bounds.size.width, height: view.bounds.size.height - 100))
        albumMenuTableView = UITableView(frame: rect, style: .plain)
        albumMenuTableView?.delegate = self
        albumMenuTableView?.dataSource = self
        albumMenuTableView?.tableFooterView = UIView()
        albumMenuTableView?.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 1))
        albumMenuTableView?.tableHeaderView?.backgroundColor = UIColor.black
        albumMenuTableView?.separatorStyle = .none
        albumMenuTableView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        albumMenuTableView?.backgroundColor = UIColor.clear
        albumMenuTableView?.register(AlbumCell.self, forCellReuseIdentifier: "albumCell")
        view.bringSubviewToFront(navigationView!)
        view.insertSubview(albumMenuTableView!, belowSubview: navigationView!)
        albumMenuTableView?.reloadData()
        albumMenuTableView?.transform = CGAffineTransformMakeTranslation(0, -view.bounds.size.height)
        UIView.animate(withDuration: 0.25) {
            self.albumMenuTableView?.transform = CGAffineTransform.identity
        }
    }
    
    func dimissAlbumMenu() {
        UIView.animate(withDuration: 0.25) {
            self.albumMenuTableView?.transform = CGAffineTransformMakeTranslation(0, -self.view.bounds.size.height)
        } completion: { finished in
            self.albumMenuTableView?.removeFromSuperview()
            self.albumMenuTableView = nil
        }
    }
    
    func updateTitle(_ name: String?) {
        DispatchQueue.main.async {
            self.navigationView?.titleButton?.setTitle(name, for: .normal)
        }
    }
}

extension AlbumMainViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sourceCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : AlbumCell = albumMenuTableView?.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as! AlbumCell
        if (indexPath.row < self.sourceCount()) {
            cell.configWithModel(self.viewModel.data?.albumCollectionAtIndex(indexPath.row))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.data?.updateCurrentAlbumCollectionWithIndex(indexPath.row)
        self.updateTitle(self.viewModel.data?.currentCollectionModel?.name)
        self.slidingViewController.reloadViewControllers()
        self.dimissAlbumMenu()
    }
    
    func sourceCount() -> Int {
        return viewModel.data?.collectionModels.count ?? 0
    }
}
