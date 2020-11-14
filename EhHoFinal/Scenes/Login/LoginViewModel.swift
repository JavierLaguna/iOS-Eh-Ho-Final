//
//  LoginViewModel.swift
//  EhHoFinal
//
//  Created by Javier Laguna on 14/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol LoginViewDelegate: class {
    func errorLoginUser(error: String)
}

final class LoginViewModel {
    
    // MARK: Properties
    private let loginDataManager: LoginDataManager
    
    weak var viewDelegate: LoginViewDelegate?
    //    weak var coordinatorDelegate: TopicDetailCoordinatorDelegate?
    
    // MARK: Lifecycle
    init(loginDataManager: LoginDataManager) {
        self.loginDataManager = loginDataManager
    }
    
    // MARK: Public Functions
    func loginUser(username: String, password: String) {
        guard !username.isEmpty, !password.isEmpty else {
            viewDelegate?.errorLoginUser(error: "login.emptyFields.error".localized())
            return
        }
        
        loginDataManager.loginUser(username: username, password: password) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                print()
                
            case .failure(let error):
                Log.error(error)
                self.viewDelegate?.errorLoginUser(error: "login.default.error".localized())
            }
        }
    }
}
