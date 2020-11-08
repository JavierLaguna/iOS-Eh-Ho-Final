//
//  AddPostViewController.swift
//  EhHoFinal
//
//  Created by Javier Laguna on 07/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

final class AddPostViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak private var titleTopicLabel: UILabel!
    @IBOutlet weak private var bodyLabel: UILabel!
    @IBOutlet weak private var bodyTextView: UITextView!
    
    // MARK: Properties
    private let viewModel: AddPostViewModel
    
    // MARK: Lifecycle
    init(viewModel: AddPostViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        localize()
        configureNavigationBar()
    }
    
    // MARK: Private Functions
    private func configureUI() {
        titleTopicLabel.font = .bigTitle
        
        bodyLabel.font = .title
        
        bodyTextView.font = .paragraph2
        bodyTextView.layer.borderWidth = 1
        bodyTextView.layer.cornerRadius = 8
        bodyTextView.layer.borderColor = UIColor.orangeKCPumpkin.cgColor
    }
    
    private func localize() {
        bodyLabel.text = "addPost.body.label".localized()
    }
    
    private func configureNavigationBar() {
        title = "addPost.title".localized()
        
        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(title: "addPost.cancel".localized(), style: .plain, target: self, action: #selector(cancelButtonTapped))
        leftBarButtonItem.tintColor = .orangeKCPumpkin
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(title: "addPost.create".localized(), style: .done, target: self, action: #selector(submitButtonTapped))
        rightBarButtonItem.tintColor = .orangeKCPumpkin
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func showErrorAddingTopicAlert(text: String?) {
        showAlert(text ?? "addPost.defaultError".localized())
    }
    
    @objc private func cancelButtonTapped() {
//        viewModel.cancelButtonTapped()
    }
    
    @objc private func submitButtonTapped() {
        guard let body = bodyTextView.text, !body.isEmpty else { return }
        
//        viewModel.submitButtonTapped(title: title, body: body)
    }
}

// MARK: AddPostViewDelegate
extension AddPostViewController: AddPostViewDelegate {
    
    func loadTopic() {
    
    }
    
    func errorAddingPost(text: String?) {
    
    }
}
