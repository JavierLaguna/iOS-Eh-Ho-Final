//
//  UserDefaultsManager.swift
//  EhHoFinal
//
//  Created by Javier Laguna on 14/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

final class UserDefaultsManager {
    
    // MARK: Public Functions - Save
    
    static func saveObject<T:Codable>(_ object: T, forKey key: String) {
        guard let data = try? JSONEncoder().encode(object) else { return }
        
        self.saveData(data, forKey: key)
    }
    
    static func removeObject(forKey key: String) {
        UserDefaults.standard.set(nil, forKey: key)
    }
    
    // MARK: Public Functions - Get
    
    static func getObject<T:Codable>(forKey key: String) -> T? {
        let decoder = JSONDecoder()

        guard let data = getData(forKey: key),
            let object = try? decoder.decode(T.self, from: data) else {
            return nil
        }

        return object
    }
    
    // MARK: Private functions
    
    static private func saveData(_ data: Data, forKey: String) {
        UserDefaults.standard.set(data, forKey: forKey)
    }
    
    static private func getData(forKey: String) -> Data? {
        return UserDefaults.standard.data(forKey: forKey)
    }
}
