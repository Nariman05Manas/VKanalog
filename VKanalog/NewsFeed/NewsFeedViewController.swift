//
//  NewsFeedViewController.swift
//  VKanalog
//
//  Created by qwerty on 01.02.2023.
//

import UIKit
import Foundation
import TinyConstraints
import RealmSwift

protocol NewsFeedDisplayLogic: AnyObject {
    func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData)
}

final class NewsFeedViewController: UIViewController, NewsFeedDisplayLogic {
    
    var interactor: NewsFeedBusinessLogic?
    private var feedViewModel = FeedViewModel(posts: [])
    let defaults = UserDefaults.standard
    let refreshControl = UIRefreshControl()
    
    private func getNews() {
        interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getNewsFeed)
    }
    
    // MARK: UI
    lazy var feedTableView: UITableView = {
        let table = UITableView()
        return table
    }()
    
    private lazy var allertAboutNewFeed: UILabel = {
        let allertAboutNewFeed = UILabel()
        allertAboutNewFeed.text = VCConstants.alertText
        allertAboutNewFeed.backgroundColor = VCConstants.alertBackgroundColor
        allertAboutNewFeed.textAlignment = .center
        allertAboutNewFeed.textColor = VCConstants.alertTextColor
        allertAboutNewFeed.layer.cornerRadius = VCConstants.alertBorderCornerRadius
        allertAboutNewFeed.layer.borderWidth = VCConstants.alertBorderWidth
        allertAboutNewFeed.layer.borderColor = VCConstants.alertBorderColor
        allertAboutNewFeed.clipsToBounds = true
        allertAboutNewFeed.isHidden = true
        return allertAboutNewFeed
    }()
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = NewsFeedInteractor()
        let presenter             = NewsFeedPresenter()
        viewController.interactor = interactor
        interactor.presenter      = presenter
        presenter.viewController  = viewController
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = VCConstants.mainViewBackgroungColor
        setup()
        UISetup()
        getNews()
        // ??????????????????????
        NotificationCenter.default.addObserver(self, selector: #selector(reloadNews), name: NSNotification.Name(rawValue: VCConstants.reloadNews), object: nil)
    }
    
    private func UISetup() {
        view.addSubviews(views: feedTableView, allertAboutNewFeed)
        feedTableView.separatorStyle = .none
        feedTableView.backgroundColor = .clear
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.register(NewsFeedCell.self, forCellReuseIdentifier: NewsFeedCell.id)
        feedTableView.estimatedRowHeight =  UITableView.automaticDimension
        feedTableView.topToSuperview(usingSafeArea: true)
        feedTableView.bottomToSuperview(offset: VCConstants.tableViewBottomOffset, usingSafeArea: true)
        feedTableView.widthToSuperview()
        allertAboutNewFeed.topToSuperview(usingSafeArea: true)
        allertAboutNewFeed.leftToSuperview(offset: 50)
        allertAboutNewFeed.rightToSuperview(offset: -50)
        
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        feedTableView.addSubview(refreshControl)
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
        getNews()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.refreshControl.endRefreshing()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.feedTableView.reloadData()
            }
        }
    }
    
    @objc func reloadNews() {
        getNews()
        self.feedTableView.reloadData()
    }
    
    func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData) {
        
        switch viewModel {
            
        case .displayNewsFeed(feedViewModel: let feedViewModel):
            self.feedViewModel = feedViewModel
            feedTableView.reloadData()
            
            // ?????????????????? ???????????????????? ???????????? ?? ????????????
            if defaults.integer(forKey: "oldPostsCount") ==  0 {
                defaults.set(feedViewModel.posts.count, forKey: "newPostCount")
                defaults.set(feedViewModel.posts.count, forKey: "oldPostsCount")
            } else {
                let oldPostCountForSave = defaults.integer(forKey: "newPostCount")
                let newPostCountForSave = feedViewModel.posts.count
                defaults.set(oldPostCountForSave, forKey: "oldPostCount")
                defaults.set(newPostCountForSave, forKey: "newPostCount")
            }
            
            // ???????????????? ???????????? ???????????????????? ???????????????????????????? ?????????????????? ???? ????????????
            let finalPostIndex = defaults.integer(forKey: "index")
            // ???????????????? ???????????????? ???????????????????? ????????????, ?????????????? ???????? ???? ???????????????????? ??????????????
            let oldPostCount = defaults.integer(forKey: "oldPostCount")
            // ???????????????????? ?????????????? ?????????????????? ???? ?????????????????? ?????????????????????????? ????????
            if UserDefaults.isFirstLaunch() {
                feedTableView.scrollToRow(at: [0, feedViewModel.posts.count - (oldPostCount - finalPostIndex) - 1], at: .bottom, animated: false)
            } else {
                feedTableView.scrollToRow(at: [0, feedViewModel.posts.count - (oldPostCount - finalPostIndex)], at: .top, animated: false)
            }
            
            // ???????????????????? ???????????? ?? ?????????? ????????????????????
            let newPostCount = feedViewModel.posts.count
            if newPostCount > oldPostCount {
                allertAboutNewFeed.isHidden = false
            }
        }
    }
}

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCell.id, for: indexPath) as! NewsFeedCell
        guard var feedViewModel = LocalStorage.shared.feedViewModel?.posts[indexPath.row] else { return cell }
        cell.setupCell(viewModel: feedViewModel)
        cell.layoutSubviews()
        cell.tapLike = {
            LocalStorage.shared.likeStatusUpdate(index: indexPath.row, typePage: .FeedNews)
            feedViewModel = (LocalStorage.shared.feedViewModel?.posts[indexPath.row])!
            cell.setupCell(viewModel: feedViewModel)
            tableView.reloadRows(at: [indexPath], with: .none)
            cell.layoutSubviews()
            NotificationCenter.default.post(name: Notification.Name(VCConstants.reloadFavourite), object: nil)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.posts[indexPath.row]
        return cellViewModel.totalHeight ?? 0
    }
    
    // ?????????????????? ???????????? ??????????, ???? ?????????????? ?????????????????? ????????????????????????
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let firstVisibleIndexPath = self.feedTableView.indexPathsForVisibleRows?[0]
        defaults.set(firstVisibleIndexPath?.row, forKey: "index")
        // ???????????????? ???????????? ?? ?????????? ???????????? ?????? ???????????? ???????????? "??????????????" ??????????
        if firstVisibleIndexPath == [0, 0] {
            allertAboutNewFeed.isHidden = true
        }
    }
}
