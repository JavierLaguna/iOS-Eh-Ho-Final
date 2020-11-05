//
//  String+Extensions.swift
//  EhHoFinal
//
//  Created by Javier Laguna on 05/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
