//
//  UserCellViewModel.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 01/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

protocol UserCellViewModelDelegate: class {
    func userImageFetched()
}

final class UserCellViewModel {
    
    // MARK: Properties
    static let imageSize = 100
    let user: User
    
    var textLabelText: String?
    var avatarImage: UIImage? {
        didSet {
            delegate?.userImageFetched()
        }
    }
    
    weak var delegate: UserCellViewModelDelegate?
    
    // MARK: Lifecycle
    init(user: User) {
        self.user = user
        self.textLabelText = user.name ?? user.username
        
        let avatarUrl: String = user.avatarTemplate.replacingOccurrences(of: "{size}", with: "\(UserCellViewModel.imageSize)")
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
