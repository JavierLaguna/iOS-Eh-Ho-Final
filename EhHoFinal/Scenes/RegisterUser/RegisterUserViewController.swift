//
//  RegisterUserViewController.swift
//  EhHoFinal
//
//  Created by Javier Laguna on 14/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

final class RegisterUserViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak private var emailTextField: UITextField!
    @IBOutlet weak private var usernameTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var repeatPasswordTextField: UITextField!
    @IBOutlet weak private var registerButton: UIButton!
    @IBOutlet weak private var loginButton: UIButton!
    
    // MARK: Properties
    private let viewModel: RegisterUserViewModel
    
    // MARK: Lifecycle
    init(viewModel: RegisterUserViewModel) {
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
        emailTextField.font = .paragraph
        usernameTextField.font = .paragraph
        passwordTextField.font = .paragraph
        repeatPasswordTextField.font = .paragraph
        
        registerButton.titleLabel?.font = .paragraphBold
        loginButton.titleLabel?.font = .paragraph2
    }
    
    private func localize() {
        emailTextField.placeholder = "registerUser.email.placeholder".localized()
        usernameTextField.placeholder = "registerUser.username.placeholder".localized()
        passwordTextField.placeholder = "registerUser.password.placeholder".localized()
        repeatPasswordTextField.placeholder = "registerUser.repeatPassword.placeholder".localized()
        
        registerButton.setTitle("registerUser.register.button".localized(), for: .normal)
        loginButton.setTitle("registerUser.login.button".localized(), for: .normal)
    }
    
    private func showErrorAlert(text: String) {
        showAlert(text)
    }
    
    // MARK: IBActions
    @IBAction private func onTapRegisterButton(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let confirmPassword = repeatPasswordTextField.text ?? ""
        
        viewModel.registerUser(email: email, username: username, password: password, confirmPassword: confirmPassword)
    }
    
    @IBAction private func onTapLoginButton(_ sender: Any) {
        viewModel.login()
    }
}

// MARK: RegisterUserViewDelegate
extension RegisterUserViewController: RegisterUserViewDelegate {
    
    func errorOnRegisterUser(error: String) {
        showErrorAlert(text: error)
    }
}
