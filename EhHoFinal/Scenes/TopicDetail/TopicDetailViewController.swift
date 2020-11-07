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
    }
    
    //    override func loadView() {
    //        view = UIView()
    //        view.backgroundColor = .white
    //
    //        view.addSubview(topicIDStackView)
    //        NSLayoutConstraint.activate([
    //            topicIDStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
    //            topicIDStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
    //        ])
    //
    //        view.addSubview(topicNameStackView)
    //        NSLayoutConstraint.activate([
    //            topicNameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
    //            topicNameStackView.topAnchor.constraint(equalTo: topicIDStackView.bottomAnchor, constant: 8)
    //        ])
    //
    //        view.addSubview(postsNumberStackView)
    //        NSLayoutConstraint.activate([
    //            postsNumberStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
    //            postsNumberStackView.topAnchor.constraint(equalTo: topicNameStackView.bottomAnchor, constant: 8)
    //        ])
    //
    //        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
    //        leftBarButtonItem.tintColor = .black
    //        navigationItem.leftBarButtonItem = leftBarButtonItem
    //    }
    
    
    // MARK: Private functions
    private func configureTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: ParentPostCell.nibName, bundle: nil), forCellReuseIdentifier: ParentPostCell.defaultReuseIdentifier)
    }
    
    private func updateUI() {
        //        labelTopicID.text = viewModel.labelTopicIDText
        //        labelTopicTitle.text = viewModel.labelTopicNameText
        //        postsNumberValueLabel.text = viewModel.postsNumber
        //
        //        if viewModel.canDeleteTopic {
        //            showDeleteOption()
        //        }
    }
    
    private func showErrorFetchingTopicDetailAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching topic detail\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
    
    private func showDeleteOption() {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteTopic))
        barButtonItem.tintColor = .red
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    private func showErrorDeletingTopicDetailAlert() {
        let alertMessage: String = NSLocalizedString("Error deleting topic\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
    
    @objc private func deleteTopic() {
        showDeleteAlert(title: "Delete Topic") { [weak self] in
            self?.viewModel.deleteTopic()
        }
    }
    
    @objc func backButtonTapped() {
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0, let cell = tableView.dequeueReusableCell(withIdentifier: ParentPostCell.defaultReuseIdentifier, for: indexPath) as? ParentPostCell {
            
            return cell
        }
        
        return UITableViewCell()
    }
    
}

// MARK: UITableViewDelegate
extension TopicDetailViewController: UITableViewDelegate {
    
}
