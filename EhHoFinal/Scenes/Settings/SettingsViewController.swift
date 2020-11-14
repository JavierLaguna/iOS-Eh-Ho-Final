//
//  SettingsViewController.swift
//  EhHoFinal
//
//  Created by Javier Laguna on 14/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    // MARK: Properties
    private let viewModel: SettingsViewModel

    // MARK: Lifecycle
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
    }

    // MARK: Private functions
    private func configureNavigationBar() {
        title = "settings.title".localized()
        
        let logoutIcon = UIImage(systemName: "power")
        let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: logoutIcon, style: .plain, target: self, action: #selector(logout))
        rightBarButtonItem.tintColor = .orangeKCPumpkin
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc private func logout() {
        viewModel.logoutUser()
    }
}
