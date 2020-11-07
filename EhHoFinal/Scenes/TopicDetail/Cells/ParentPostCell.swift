//
//  ParentPostCell.swift
//  EhHoFinal
//
//  Created by Javier Laguna on 07/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

final class ParentPostCell: UITableViewCell, NibLoadableView, ReusableView  {
    
    // MARK: IBOutlets
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var postCountLabel: UILabel!
    @IBOutlet weak private var posterCountLabel: UILabel!
    @IBOutlet weak private var createdPostLabel: UILabel!
    @IBOutlet weak private var bodyLabel: UILabel!
    
    var viewModel: ParentPostCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            titleLabel.text = viewModel.titleLabelText
            postCountLabel.text = viewModel.postsCount
            posterCountLabel.text = viewModel.postersCount
            createdPostLabel.text = viewModel.createPostDate
            bodyLabel.text = viewModel.bodyLabelText?.htmlToString
        }
    }
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    
    // MARK: Private Functions
    private func configureUI() {
        titleLabel.font = .bigTitle
        postCountLabel.font = .cellDetail
        posterCountLabel.font = .cellDetail
        createdPostLabel.font = .cellDetailBold
        bodyLabel.font = .paragraph
    }
}
