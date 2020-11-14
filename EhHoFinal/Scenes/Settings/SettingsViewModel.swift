//
//  SettingsViewModel.swift
//  EhHoFinal
//
//  Created by Javier Laguna on 14/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol SettingsCoordinatorDelegate: class {
    func logout()
}

final class SettingsViewModel {
    
    // MARK: Properties
    private let loginDataManager: LoginDataManager
    
    weak var coordinatorDelegate: SettingsCoordinatorDelegate?
    
    // MARK: Lifecycle
    init(loginDataManager: LoginDataManager) {
        self.loginDataManager = loginDataManager
    }
    
    // MARK: Public Functions
    func logoutUser() {
        loginDataManager.deleteUserLogged() { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                self.coordinatorDelegate?.logout()
            case .failure:
                break
            }
        }
    }
}

