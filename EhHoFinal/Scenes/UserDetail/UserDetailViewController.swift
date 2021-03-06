//
//  UserDetailViewController.swift
//  EhHoFinal
//
//  Created by Javier Laguna on 05/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewController que representa el detalle de un User
final class UserDetailViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet private weak var slideBarView: UIView!
    @IBOutlet private weak var avatarImage: UIImageView!
    @IBOutlet private weak var nickLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var lastConnectionLabel: UILabel!
    @IBOutlet private weak var numTopicsLabel: UILabel!
    @IBOutlet private weak var topicsLabel: UILabel!
    @IBOutlet private weak var numRepliesLabel: UILabel!
    @IBOutlet private weak var repliesLabel: UILabel!
    @IBOutlet private weak var numLikesLabel: UILabel!
    @IBOutlet private weak var likesLabel: UILabel!
    @IBOutlet private weak var numMyLikesLabel: UILabel!
    @IBOutlet private weak var myLikesLabel: UILabel!
    @IBOutlet private weak var badgesLabel: UILabel!
    @IBOutlet private weak var modBadgeView: UIStackView!
    @IBOutlet private weak var userBadgeView: UIStackView!
    @IBOutlet private weak var modBadgeLabel: UILabel!
    @IBOutlet private weak var userBadgeLabel: UILabel!
    
    // MARK: Properties
    private let viewModel: UserDetailViewModel
    
    // MARK: Lifecycle
    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
        
        configureUI()
        localize()
    }
    
    // MARK: Private Functions
    private func configureUI() {
        slideBarView.layer.cornerRadius = 2
        
        avatarImage.alpha = 0
        avatarImage.asCircle()
        
        nickLabel.font = .bigTitle
        nickLabel.text = ""
        nameLabel.font = .paragraph
        nameLabel.text = ""
        lastConnectionLabel.font = .cellDetail
        lastConnectionLabel.text = ""
        
        numTopicsLabel.font = .title
        numTopicsLabel.text = "0"
        topicsLabel.font = .paragraph4
        numRepliesLabel.font = .title
        numRepliesLabel.text = "0"
        repliesLabel.font = .paragraph4
        numLikesLabel.font = .title
        numLikesLabel.text = "0"
        likesLabel.font = .paragraph4
        numMyLikesLabel.font = .title
        numMyLikesLabel.text = "0"
        myLikesLabel.font = .paragraph4
        
        badgesLabel.font = .title
        modBadgeLabel.font = .paragraph4
        userBadgeLabel.font = .paragraph4
        
        modBadgeView.isHidden = true
    }
    
    private func localize() {
        topicsLabel.text = "userDetail.topics_created".localized()
        repliesLabel.text = "userDetail.replies".localized()
        
        likesLabel.text = "userDetail.likes".localized()
        myLikesLabel.text = "userDetail.my_likes".localized()
        
        badgesLabel.text = "userDetail.badge.title".localized()
        modBadgeLabel.text = "userDetail.badge.mod".localized()
        userBadgeLabel.text = "userDetail.badge.user".localized()
    }
    
    private func updateUI() {
        nickLabel.text = viewModel.labelNickText
        nameLabel.text = viewModel.labelNameText
        lastConnectionLabel.text = viewModel.labelLastConnectionText
        
        numMyLikesLabel.text = viewModel.labelLikesReceivedText
        
        modBadgeView.isHidden = !viewModel.isMod
    }
    
    private func updateAvatarUI() {
        avatarImage.alpha = 0
        avatarImage.image = viewModel.avatarImage
        
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.avatarImage.alpha = 1
        }
    }
    
    private func showErrorFetchingUserDetailAlert() {
        showAlert("userDetail.fetchError".localized())
    }
}

// MARK: UserDetailViewDelegate
extension UserDetailViewController: UserDetailViewDelegate {
    
    func userDetailFetched() {
        updateUI()
    }
    
    func userImageFetched() {
        updateAvatarUI()
    }
    
    func errorFetchingUserDetail() {
        showErrorFetchingUserDetailAlert()
    }
    
    func errorModifingUserDetail() {
        return
    }
    
    func successModifingUserDetail() {
        return
    }
}
