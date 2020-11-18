//
//  UsersViewModel.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 01/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate a través del cual nos vamos a comunicar con el coordinator, contándole todo aquello que atañe a la navegación
protocol UsersCoordinatorDelegate: class {
    func didSelect(user: User)
}

/// Delegate a través del cual vamos a comunicar a la vista eventos que requiran pintar el UI, pasándole aquellos datos que necesita
protocol UsersViewDelegate: class {
    func usersFetched()
    func errorFetchingUsers()
}

/// ViewModel que representa un listado de users
final class UsersViewModel {
    
    // MARK: Properties
    private let usersDataManager: UsersDataManager
    
    var usersViewModels: [UserCellViewModel] = []
    var searchText: String? {
        didSet {
            if searchText != oldValue {
                viewDelegate?.usersFetched()
            }
        }
    }
    var usersTopics: [UserCellViewModel] {
        guard let searchText = searchText, !searchText.isEmpty else { return usersViewModels }
        
        return usersViewModels.filter { user in
            return user.textLabelText?.lowercased().contains(searchText.lowercased()) ?? false
        }
    }
    
    weak var coordinatorDelegate: UsersCoordinatorDelegate?
    weak var viewDelegate: UsersViewDelegate?
    
    // MARK: Lifecycle
    init(usersDataManager: UsersDataManager) {
        self.usersDataManager = usersDataManager
    }
    
    func viewWasLoaded() {
        getLocalUsers()
        fetchUsers()
    }
    
    // MARK: Public Functions
    func refreshUsers() {
        fetchUsers()
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return usersTopics.count
    }
    
    func viewModel(at indexPath: IndexPath) -> UserCellViewModel? {
        guard indexPath.row < usersTopics.count else { return nil }
        return usersTopics[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < usersTopics.count else { return }
        coordinatorDelegate?.didSelect(user: usersTopics[indexPath.row].user)
    }
    
    // MARK: Private Functions
    private func updateUsers(_ users: Users) {
        usersViewModels = users.map { UserCellViewModel(user: $0) }
        viewDelegate?.usersFetched()
    }
    
    private func getLocalUsers() {
        usersDataManager.getUsers() { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let users):
                self.updateUsers(users)
            case .failure(let error):
                Log.error(error)
            }
        }
    }
    
    private func fetchUsers() {
        usersDataManager.fetchAllUsers { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let usersResp):
                guard let users = usersResp?.users else { return }
                
                self.saveUsers(users)
                self.updateUsers(users)
                
            case .failure(let error):
                Log.error(error)
                self.viewDelegate?.errorFetchingUsers()
            }
        }
    }
    
    private func saveUsers(_ users: Users) {
        usersDataManager.saveUsers(users: users, completion: nil)
    }
}
