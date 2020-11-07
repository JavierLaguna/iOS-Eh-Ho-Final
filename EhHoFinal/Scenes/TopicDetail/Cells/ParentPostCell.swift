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
    
    //    var viewModel: TopicPostCellViewModel? {
    //        didSet {
    //            guard let viewModel = viewModel else { return }
    //
    //            postTitleLabel.text = viewModel.textLabelText
    //            postCountLabel.text = viewModel.postsCount
    //            posterCountLabel.text = viewModel.postersCount
    //            lastPostLabel.text = viewModel.lastPostDate
    //            lastPosterImage.image = viewModel.lastPosterImage
    //
    //            viewModel.delegate = self
    //        }
    //    }
    
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
        
        titleLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
        bodyLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas sagittis felis eu ornare interdum. Donec a est vitae lectus imperdiet blandit. Duis commodo erat justo, ut sollicitudin nibh sagittis ut. Fusce interdum felis in congue tincidunt. "
    }
}
