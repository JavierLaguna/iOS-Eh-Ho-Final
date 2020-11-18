//
//  UserDetailViewModel.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 05/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation
import UIKit

/// Delegate que usaremos para comunicar eventos relativos a navegación, al coordinator correspondiente
protocol UserDetailCoordinatorDelegate: class {
    func userDetailBackButtonTapped(needUpdateUsers: Bool)
}

/// Delegate para comunicar a la vista cosas relacionadas con UI
protocol UserDetailViewDelegate: class {
    func userDetailFetched()
    func userImageFetched()
    func errorFetchingUserDetail()
    func errorModifingUserDetail()
    func successModifingUserDetail()
}

final class UserDetailViewModel {
    
    // MARK: Properties
    static let imageSize = 185
    
    private let userDetailDataManager: UserDetailDataManager
    let username: String
    
    var userModified = false
    var labelNickText: String?
    var labelNameText: String?
    var labelLastConnectionText: String?
    var labelLikesReceivedText: String?
    var isMod = false
    var avatarImage: UIImage? {
        didSet {
            viewDelegate?.userImageFetched()
        }
    }
    
    weak var viewDelegate: UserDetailViewDelegate?
    weak var coordinatorDelegate: UserDetailCoordinatorDelegate?
    
    // MARK: Lifecycle
    init(username: String, userDetailDataManager: UserDetailDataManager) {
        self.username = username
        self.userDetailDataManager = userDetailDataManager
    }
    
    func viewDidLoad() {
        fetchUser()
    }
    
    // MARK: Public Functions
    func modifyUser(newName: String) {
        userDetailDataManager.updateName(username: username, name: newName) { [weak self] result in
            guard let self = self else { return}
            
            switch result {
            case .success:
                self.userModified = true
                self.viewDelegate?.successModifingUserDetail()
            case .failure(let error):
                Log.error(error)
                self.viewDelegate?.errorModifingUserDetail()
            }
        }
    }
    
    func backButtonTapped() {
        coordinatorDelegate?.userDetailBackButtonTapped(needUpdateUsers: userModified)
    }
    
    // MARK: Private Functions
    private func fetchUser() {
        userDetailDataManager.fetchUser(username: username) { [weak self] result in
            guard let self = self else { return}
            
            switch result {
            case .success(let userResp):
                guard let user = userResp?.user else { return }
                
                self.fetchUserAvatar(avatarTemplate: user.avatarTemplate)
                
                self.labelNickText = user.username
                self.labelNameText = user.name
                self.isMod = user.moderator ?? false
                
                if let lastSeenAt = user.lastSeenAt {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "E, d MMM yyyy HH:mm"
                    self.labelLastConnectionText = formatter.string(from: lastSeenAt)
                }
                
                if let profileViewCount = user.profileViewCount {
                    self.labelLikesReceivedText = "\(profileViewCount)"
                }
                
                self.viewDelegate?.userDetailFetched()
                
            case .failure(let error):
                Log.error(error)
                self.viewDelegate?.errorFetchingUserDetail()
            }
        }
    }
    
    private func fetchUserAvatar(avatarTemplate: String) {
        let avatarUrl: String = avatarTemplate.replacingOccurrences(of: "{size}", with: "\(UserDetailViewModel.imageSize)")
        if let imageUrl = URL(string: "\(apiURL)\(avatarUrl)") {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                guard let data = try? Data(contentsOf: imageUrl),
                      let image = UIImage(data: data) else { return }
                
                DispatchQueue.main.async {
                    self?.avatarImage = image
                }
            }
        }
    }
}
