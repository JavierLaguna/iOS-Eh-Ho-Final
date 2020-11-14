//
//  CategoriesViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol CategoriesViewDelegate: class {
    func categoriesFetched()
    func errorFetchingCategories()
}

/// ViewModel representando un listado de categorías
final class CategoriesViewModel {
    
    // MARK: Properties
    private let categoriesDataManager: CategoriesDataManager
    private var categoriesViewModels: [CategoryCellViewModel] = []
    
    weak var viewDelegate: CategoriesViewDelegate?
    
    // MARK: Lifecycle
    init(categoriesDataManager: CategoriesDataManager) {
        self.categoriesDataManager = categoriesDataManager
    }
    
    func viewWasLoaded() {
        fetchCategories()
    }
    
    // MARK: Public Functions
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return categoriesViewModels.count
    }
    
    func viewModel(at indexPath: IndexPath) -> CategoryCellViewModel? {
        guard indexPath.row < categoriesViewModels.count else { return nil }
        return categoriesViewModels[indexPath.row]
    }
    
    // MARK: Private Functions
    private func fetchCategories() {
        categoriesDataManager.fetchAllCategories { [weak self] result in
            guard let self = self else { return}
            
            switch result {
            case .success(let categoriesResp):
                guard let categories = categoriesResp?.categories else { return }
                self.categoriesViewModels = categories.map { CategoryCellViewModel(category: $0) }
                
                self.viewDelegate?.categoriesFetched()
                
            case .failure(let error):
                Log.error(error)
                self.viewDelegate?.errorFetchingCategories()
            }
        }
    }
}
