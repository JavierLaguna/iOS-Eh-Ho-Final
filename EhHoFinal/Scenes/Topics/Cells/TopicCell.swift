//
//  TopicCell.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// Celda que representa un topic en la lista
final class TopicCell: UITableViewCell, NibLoadableView, ReusableView {
    
    // MARK: IBOutlets
    @IBOutlet weak private var lastPosterImage: UIImageView!
    @IBOutlet weak private var postTitleLabel: UILabel!
    @IBOutlet weak private var postCountLabel: UILabel!
    @IBOutlet weak private var posterCountLabel: UILabel!
    @IBOutlet weak private var lastPostLabel: UILabel!
    
    var viewModel: TopicPostCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            postTitleLabel.text = viewModel.textLabelText
            postCountLabel.text = viewModel.postsCount
            posterCountLabel.text = viewModel.postersCount
            lastPostLabel.text = viewModel.lastPostDate
            lastPosterImage.image = viewModel.lastPosterImage
            
            viewModel.delegate = self
        }
    }
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        lastPosterImage.image = nil
    }
    
    // MARK: Private Functions
    private func configureUI() {
        lastPosterImage.asCircle()
        postTitleLabel.font = .title
        
        postCountLabel.font = .cellDetail
        posterCountLabel.font = .cellDetail
        lastPostLabel.font = .cellDetailBold
    }
    
    private func showImage(_ image: UIImage?) {
        lastPosterImage.alpha = 0
        lastPosterImage.image = image
        
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.lastPosterImage.alpha = 1
        }
    }
}

// MARK: TopicCellViewModelDelegate
extension TopicCell: TopicPostCellViewModelDelegate {
    
    func userImageFetched() {
        guard let image = viewModel?.lastPosterImage else { return }
        
        showImage(image)
    }
}
