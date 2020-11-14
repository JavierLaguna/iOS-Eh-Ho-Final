//
//  LoginDataManager.swift
//  EhHoFinal
//
//  Created by Javier Laguna on 14/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol LoginDataManager: class {
    
    func loginUser(username: String, password: String, completion: @escaping (Result<UserDetailResponse?, Error>) -> ())
    func saveUserLogged(user: UserLogged, completion: @escaping (Result<Bool, Error>) -> ())
    func getUserLogged(completion: @escaping (Result<UserLogged?, Error>) -> ())
    func deleteUserLogged(completion: @escaping (Result<Bool, Error>) -> ())
}
