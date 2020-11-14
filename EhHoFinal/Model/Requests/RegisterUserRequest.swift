//
//  RegisterUserRequest.swift
//  EhHoFinal
//
//  Created by Javier Laguna on 14/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct RegisterUserRequest: APIRequest {
    
    typealias Response = RegisterUserResponse
    
    private let email: String
    private let username: String
    private let password: String
    
    init(email: String, username: String, password: String) {
        self.email = email
        self.username = username
        self.password = password
    }
    
    var method: Method {
        return .POST
    }
    
    var path: String {
        return "/users"
    }
    
    var parameters: [String : String] {
        return [
            "name": username,
            "username": username,
            "email": email,
            "password": password,
            "active": "true",
            "approved": "true"
        ]
    }
    
    var body: [String : Any] {
        return [:]
    }
    
    var headers: [String : String] {
        return [:]
    }
}
