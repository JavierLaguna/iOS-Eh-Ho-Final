//
//  RegisterUserViewModel.swift
//  EhHoFinal
//
//  Created by Javier Laguna on 14/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol RegisterUserViewDelegate: class {
    func errorOnRegisterUser(error: String)
}

protocol RegisterUserCoordinatorDelegate: class {
    func backToLogin()
}

final class RegisterUserViewModel {
    
    // MARK: Properties
    private let loginDataManager: LoginDataManager
    
    weak var viewDelegate: RegisterUserViewDelegate?
    weak var coordinatorDelegate: RegisterUserCoordinatorDelegate?
    
    // MARK: Lifecycle
    init(loginDataManager: LoginDataManager) {
        self.loginDataManager = loginDataManager
    }
    
    // MARK: Public Functions
    func registerUser(email: String,username: String, password: String, confirmPassword: String) {
        let formIsValid = validateFields(email: email, username: username, password: password, confirmPassword: confirmPassword)
        
        
        //        loginDataManager.loginUser(username: username, password: password) { [weak self] result in
        //            guard let self = self else { return }
        //
        //            switch result {
        //            case .success:
        //                self.userIsLogged(username: username, password: password)
        //
        //            case .failure(let error):
        //                Log.error(error)
        //                self.viewDelegate?.errorLoginUser(error: "login.default.error".localized())
        //            }
        //        }
    }
    
    func login() {
        coordinatorDelegate?.backToLogin()
    }
    
    // MARK: Private Functions
    private func validateFields(email: String,username: String, password: String, confirmPassword: String) -> Bool {
        
        guard  !email.isEmpty,
               !username.isEmpty,
               !password.isEmpty,
               !confirmPassword.isEmpty else {
            
            viewDelegate?.errorOnRegisterUser(error: "registerUser.emptyFields.error".localized())
            return false
        }
        
        if password != confirmPassword {
            viewDelegate?.errorOnRegisterUser(error: "registerUser.notSamePassword.error".localized())
            return false
        }
        
        return true
    }
}
