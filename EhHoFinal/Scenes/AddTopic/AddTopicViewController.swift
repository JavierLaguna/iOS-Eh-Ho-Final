//
//  AddTopicViewController.swift
//  EhHoFinal
//
//  Created by Javier Laguna on 03/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class AddTopicViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var titleTextField: UITextField!
    @IBOutlet weak private var bodyLabel: UILabel!
    @IBOutlet weak private var bodyTextView: UITextView!
    
    // MARK: Constants
    private let viewModel: AddTopicViewModel
    
    // MARK: Lifecycle
    init(viewModel: AddTopicViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNavigationBar()
    }
    
    // MARK: Private Functions
    private func configureUI() {
        titleLabel.font = .title
        titleLabel.text = "addTopic.title.label".localized()
        
        titleTextField.font = .paragraph2
        titleTextField.placeholder = "addTopic.title.placeholder".localized()
        titleTextField.layer.borderWidth = 1
        titleTextField.layer.cornerRadius = 8
        titleTextField.layer.borderColor = UIColor.orangeKCPumpkin.cgColor
        
        bodyLabel.font = .title
        bodyLabel.text = "addTopic.body.label".localized()
        
        bodyTextView.font = .paragraph2
        bodyTextView.layer.borderWidth = 1
        bodyTextView.layer.cornerRadius = 8
        bodyTextView.layer.borderColor = UIColor.orangeKCPumpkin.cgColor
    }
    
    private func configureNavigationBar() {
        title = "addTopic.title".localized()
        
        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(title: "addTopic.cancel".localized(), style: .plain, target: self, action: #selector(cancelButtonTapped))
        leftBarButtonItem.tintColor = .orangeKCPumpkin
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(title: "addTopic.create".localized(), style: .done, target: self, action: #selector(submitButtonTapped))
        rightBarButtonItem.tintColor = .orangeKCPumpkin
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func showErrorAddingTopicAlert() {
        let message = NSLocalizedString("Error adding topic\nPlease try again later", comment: "")
        showAlert(message)
    }
    
    @objc private func cancelButtonTapped() {
        viewModel.cancelButtonTapped()
    }
    
    @objc private func submitButtonTapped() {
        guard let title = titleTextField.text, !title.isEmpty,
              let body = bodyTextView.text, !body.isEmpty else { return }
        
        viewModel.submitButtonTapped(title: title, body: body)
    }
}

// MARK: AddTopicViewDelegate
extension AddTopicViewController: AddTopicViewDelegate {
    func errorAddingTopic() {
        showErrorAddingTopicAlert()
    }
}
