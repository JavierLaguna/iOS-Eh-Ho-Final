//
//  TopicPinnedCell.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 21/05/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

final class TopicPinnedCell: UITableViewCell, NibLoadableView, ReusableView  {

    @IBOutlet weak private var containerView: UIView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var subtitleLabel: UILabel!
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    // MARK: Private Functions
    private func configureUI() {
        containerView.layer.cornerRadius = 8
        titleLabel.font = UIFont.bigTitle
        subtitleLabel.font = UIFont.paragraph
    }
}
