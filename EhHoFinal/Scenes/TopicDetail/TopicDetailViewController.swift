//
//  TopicDetailViewController.swift
//  EhHoFinal
//
//  Created by Javier Laguna on 07/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewController que representa el detalle de un Topic
final class TopicDetailViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: Properties
    private let viewModel: TopicDetailViewModel
    private let fetchNextPageOffset = 7
    
    // MARK: Lifecycle
    init(viewModel: TopicDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
        
        configureTable()
        configureNavigationBar()
    }
    
    // MARK: Private functions
    private func configureTable() {
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        tableView.register(UINib(nibName: ParentPostCell.nibName, bundle: nil), forCellReuseIdentifier: ParentPostCell.defaultReuseIdentifier)
        tableView.register(UINib(nibName: PostCell.nibName, bundle: nil), forCellReuseIdentifier: PostCell.defaultReuseIdentifier)
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.titleView = nil
        
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        leftBarButtonItem.tintColor = .orangeKCPumpkin
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.message"), style: .plain, target: self, action: #selector(replyButtonTapped))
        rightBarButtonItem.tintColor = .orangeKCPumpkin
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func updateUI() {
        tableView.reloadData()
        
        if viewModel.canDeleteTopic {
            showDeleteOption()
        }
    }
    
    private func showDeleteOption() {
        let deleteBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteTopic))
        deleteBarButtonItem.tintColor = .orangeKCPumpkin
        
        navigationItem.rightBarButtonItems?.append(deleteBarButtonItem)
    }
    
    private func showErrorFetchingTopicDetailAlert() {
        showAlert("topicDetail.fetchError".localized())
    }
    
    private func showErrorDeletingTopicDetailAlert() {
        showAlert("topicDetail.deleteError".localized())
    }
    
    @objc func replyButtonTapped() {
        viewModel.replyTopic()
    }
    
    @objc private func deleteTopic() {
        showDeleteAlert(title: "topicDetail.delete.title".localized()) { [weak self] in
            self?.viewModel.deleteTopic()
        }
    }
    
    @objc private func backButtonTapped() {
        viewModel.backButtonTapped()
    }
}

// MARK: TopicDetailViewDelegate
extension TopicDetailViewController: TopicDetailViewDelegate {
    
    func topicDetailFetched() {
        updateUI()
    }
    
    func errorFetchingTopicDetail() {
        showErrorFetchingTopicDetailAlert()
    }
    
    func errorDeletingTopicDetail() {
        showErrorDeletingTopicDetailAlert()
    }
}

// MARK: UITableViewDataSource
extension TopicDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let postsCount = viewModel.posts?.count,
           indexPath.row + fetchNextPageOffset >= postsCount {
            viewModel.fetchMorePosts()
        }
        
        guard let post = viewModel.posts?[indexPath.row] else {
            return UITableViewCell()
        }
        
        
        if indexPath.row == 0, let cell = tableView.dequeueReusableCell(withIdentifier: ParentPostCell.defaultReuseIdentifier, for: indexPath) as? ParentPostCell, let topic = viewModel.topic {
            
            let viewModelCell = ParentPostCellViewModel(topic: topic, post: post)
            cell.viewModel = viewModelCell
            return cell
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.defaultReuseIdentifier, for: indexPath) as? PostCell {
            
            let viewModelCell = PostCellViewModel(post: post)
            cell.viewModel = viewModelCell
            return cell
        }
        
        return UITableViewCell()
    }
}
