//
//  UserCellViewModel.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 01/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit


final class UserCellViewModel {
    
    // MARK: Properties
    static let imageSize = 100
    let user: User
    
    var textLabelText: String?
    var avartarUrl: URL?
    
    
    // MARK: Lifecycle
    init(user: User) {
        self.user = user
        self.textLabelText = user.name ?? user.username
        
        let avatarUrl: String = user.avatarTemplate.replacingOccurrences(of: "{size}", with: "\(UserCellViewModel.imageSize)")
        self.avartarUrl = URL(string: "\(apiURL)\(avatarUrl)")
    }
}
