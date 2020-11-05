//
//  SessionAPIError+Extensions.swift
//  EhHoFinal
//
//  Created by Javier Laguna on 05/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

extension SessionAPIError {
    
    func getErrors() -> [String]? {
        switch self {
        case .apiError(let apiError):
            return apiError.errors
        default:
            return nil
        }
    }
    
    func getFirstError() -> String? {
        guard let errors = self.getErrors() else {
            return nil
        }
        
        return errors.first
    }
}
