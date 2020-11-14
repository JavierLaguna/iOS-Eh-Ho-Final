//
//  DiscourseClientLocalDataManager.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Protocolo que representa todas las opraciones de acceso a base de datos local de la app
protocol DiscourseClientLocalDataManager {
    
    func saveUserLogged(user: UserLogged, completion: @escaping (Result<Bool, Error>) -> ())
    func getUserLogged(completion: @escaping (Result<UserLogged?, Error>) -> ())
    func deleteUserLogged(completion: @escaping (Result<Bool, Error>) -> ())
}
