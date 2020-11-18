//
//  PostCell.swift
//  EhHoFinal
//
//  Created by Javier Laguna on 07/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

final class PostCell: UITableViewCell, NibLoadableView, ReusableView  {
    
    // MARK: IBOutlets
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    
    // MARK: Properties
    var viewModel: PostCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            authorLabel.text = viewModel.author
            dateLabel.text = viewModel.postUpdatedAt
            contentLabel.text = viewModel.bodyLabelText?.htmlToString
        }
    }
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    
    // MARK: Private Functions
    private func configureUI() {
        authorLabel.font = .cellDetail
        dateLabel.font = .cellDetailBold
        contentLabel.font = .paragraph
    }
}
