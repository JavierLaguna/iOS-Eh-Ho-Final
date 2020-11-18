//
//  UserCell.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 23/05/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit
import Kingfisher

final class UserCell: UICollectionViewCell, NibLoadableView, ReusableView {
    
    // MARK: IBOutlets
    @IBOutlet weak private var avatarImage: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    
    // MARK: Properties
    var viewModel: UserCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            avatarImage.kf.setImage(with: viewModel.avartarUrl, options: [.transition(.fade(1))])
            nameLabel.text = viewModel.textLabelText
        }
    }
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarImage.image = nil
    }
    
    // MARK: Private Functions
    private func configureUI() {
        avatarImage.asCircle()
        avatarImage.layer.masksToBounds = true
        
        nameLabel.font = UIFont.cellDetail
    }
}
