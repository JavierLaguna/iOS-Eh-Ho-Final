//
//  CategoriesCoordinator.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// Coordinator que representa el tab del categories list
final class CategoriesCoordinator: Coordinator {
    
    // MARK: Properties
    private let presenter: UINavigationController
    private let categoriesDataManager: CategoriesDataManager
    
    // MARK: Lifecycle
    init(presenter: UINavigationController, categoriesDataManager: CategoriesDataManager) {
        self.presenter = presenter
        self.categoriesDataManager = categoriesDataManager
    }
    
    override func start() {
        let categoriesViewModel = CategoriesViewModel(categoriesDataManager: categoriesDataManager)
        let categoriesViewController = CategoriesViewController(viewModel: categoriesViewModel)
        
        categoriesViewController.title = "categories.title".localized()
        categoriesViewModel.viewDelegate = categoriesViewController
        
        presenter.pushViewController(categoriesViewController, animated: false)
    }
    
    override func finish() {}
}
