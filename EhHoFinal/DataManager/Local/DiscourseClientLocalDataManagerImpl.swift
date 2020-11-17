//
//  DiscourseClientLocalDataManagerImp.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 03/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation
import RealmSwift

enum RepositoryError: Error {
    case userDefaults
    case realm
}

/// Implementación por defecto
final class DiscourseClientLocalDataManagerImpl: DiscourseClientLocalDataManager {
    
    lazy private var realm = RealmWorker.shared.realm
    
}

// MARK: UserDefaults Implementation
extension DiscourseClientLocalDataManagerImpl {
    
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

// MARK: Realm Implementation
extension DiscourseClientLocalDataManagerImpl {
    
    func saveUsers(users: Users, completion: ((Result<Bool, Error>) -> ())?) {
        
        DispatchQueue.global(qos: .background).async {
            autoreleasepool{
                guard let realm = try? Realm() else {
                    completion?(.failure(RepositoryError.realm))
                    return
                }
                
                do {
                    try realm.write {
                        realm.add(users, update: .modified)
                        completion?(.success(true))
                    }
                } catch(let error) {
                    Log.error(error)
                    completion?(.failure(error))
                }
            }
        }
    }
}
