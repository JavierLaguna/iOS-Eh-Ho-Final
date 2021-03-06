//
//  DiscourseClientLocalDataManagerImp.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 03/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Implementación por defecto
final class DiscourseClientLocalDataManagerImpl: DiscourseClientLocalDataManager {
    
    private enum UserDefaultKeys: String {
        case UserLogged = "UDUserLogged"
    }
    
    func saveUserLogged(user: UserLogged, completion: @escaping (Result<Bool, Error>) -> ()) {
        UserDefaultsManager.saveObject(user, forKey: UserDefaultKeys.UserLogged.rawValue)
        
        completion(.success(true))
    }
    
    func getUserLogged(completion: @escaping (Result<UserLogged?, Error>) -> ()) {
        let user: UserLogged? = UserDefaultsManager.getObject(forKey: UserDefaultKeys.UserLogged.rawValue)
        
        completion(.success(user))
    }
    
    func deleteUserLogged(completion: @escaping (Result<Bool, Error>) -> ()) {
        UserDefaultsManager.removeObject(forKey: UserDefaultKeys.UserLogged.rawValue)
        
        completion(.success(true))
    }
}
