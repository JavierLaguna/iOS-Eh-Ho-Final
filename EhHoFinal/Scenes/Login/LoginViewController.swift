//
//  LoginViewController.swift
//  EhHoFinal
//
//  Created by Javier Laguna on 14/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak private var usernameTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var loginButton: UIButton!
    @IBOutlet weak private var registerButton: UIButton!
    
    // MARK: Properties
    private let viewModel: LoginViewModel
    
    // MARK: Lifecycle
    init(viewModel: LoginViewModel) {
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
    }
    
    // MARK: Private functions
    private func configureUI() {
        usernameTextField.font = .paragraph
        passwordTextField.font = .paragraph
        
        loginButton.titleLabel?.font = .paragraphBold
        registerButton.titleLabel?.font = .paragraph2
    }
    
    private func localize() {
        
        usernameTextField.placeholder = "login.username.placeholder".localized()
        passwordTextField.placeholder = "login.password.placeholder".localized()
        
        loginButton.setTitle("login.login.button".localized(), for: .normal)
        registerButton.setTitle("login.register.button".localized(), for: .normal)
    }
    
    private func showErrorAlert(text: String) {
        showAlert(text)
    }
    
    // MARK: IBActions
    @IBAction private func onTapLoginButton(_ sender: Any) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        viewModel.loginUser(username: username, password: password)
    }
    
    @IBAction func onTapRegisterButton(_ sender: Any) {
        viewModel.registerUser()
    }
}

// MARK: LoginViewDelegate
extension LoginViewController: LoginViewDelegate {
    
    func errorLoginUser(error: String) {
        showErrorAlert(text: error)
    }
}
