//
//  DiscourseClientDataManager.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// DataManager de la app. Usa un localDataManager y un remoteDataManager que colaboran entre ellos
/// En las extensiones de abajo, encontramos la implementación de aquellos métodos necesarios en cada módulo de la app
/// Este DataManager sólo utiliza llamadas remotas, pero podría extenderse para serialziar las respuestas, y poder implementar un offline first en el futuro
final class DiscourseClientDataManager {
    
    private let localDataManager: DiscourseClientLocalDataManager
    private let remoteDataManager: DiscourseClientRemoteDataManager
    
    init(localDataManager: DiscourseClientLocalDataManager, remoteDataManager: DiscourseClientRemoteDataManager) {
        self.localDataManager = localDataManager
        self.remoteDataManager = remoteDataManager
    }
}

// MARK: TopicsDataManager
extension DiscourseClientDataManager: TopicsDataManager {
    func fetchAllTopics(nextPage: String?, completion: @escaping (Result<LatestTopicsResponse?, Error>) -> ()) {
        remoteDataManager.fetchAllTopics(nextPage: nextPage, completion: completion)
    }
}

// MARK: TopicDetailDataManager
extension DiscourseClientDataManager: TopicDetailDataManager {
    func fetchTopic(id: Int, completion: @escaping (Result<SingleTopicResponse?, Error>) -> ()) {
        remoteDataManager.fetchTopic(id: id, completion: completion)
    }
    
    func fetchSpecificPosts(of topicId: Int, postIds: [Int], completion: @escaping (Result<SpecificPostsResponse?, Error>) -> ()) {
        remoteDataManager.fetchSpecificPosts(of: topicId, postIds: postIds, completion: completion)
    }
    
    func deleteTopic(id: Int, completion: @escaping (Result<DeleteTopicResponse?, Error>) -> ()) {
        remoteDataManager.deleteTopic(id: id, completion: completion)
    }
}

// MARK: AddTopicDataManager
extension DiscourseClientDataManager: AddTopicDataManager {
    func addTopic(title: String, raw: String, createdAt: String, completion: @escaping (Result<AddNewTopicResponse?, Error>) -> ()) {
        remoteDataManager.addTopic(title: title, raw: raw, createdAt: createdAt, completion: completion)
    }
}

// MARK: AddPostDataManager
extension DiscourseClientDataManager: AddPostDataManager {
    func addPost(topicId: Int, content: String, completion: @escaping (Result<AddNewPostResponse?, Error>) -> ()) {
        remoteDataManager.addPost(topicId: topicId, content: content, completion: completion)
    }
}

// MARK: CategoriesDataManager
extension DiscourseClientDataManager: CategoriesDataManager {    
    func fetchAllCategories(completion: @escaping (Result<CategoriesResponse?, Error>) -> ()) {
        remoteDataManager.fetchCategories(completion: completion)
    }
}

// MARK: UsersDataManager
extension DiscourseClientDataManager: UsersDataManager {
    func fetchAllUsers(completion: @escaping (Result<UsersResponse?, Error>) -> ()) {
        remoteDataManager.fetchAllUsers(completion: completion)
    }
}

// MARK: UserDetailDataManager
extension DiscourseClientDataManager: UserDetailDataManager {
    func fetchUser(username: String, completion: @escaping (Result<UserDetailResponse?, Error>) -> ()) {
        remoteDataManager.fetchUser(username: username, completion: completion)
    }
    
    func updateName(username: String, name: String, completion: @escaping (Result<UpdateNameUserResponse?, Error>) -> ()) {
        remoteDataManager.updateNameUser(username: username, name: name, completion: completion)
    }
}

// MARK: LoginDataManager
extension DiscourseClientDataManager: LoginDataManager {
    
    func loginUser(username: String, password: String, completion: @escaping (Result<UserDetailResponse?, Error>) -> ()) {
        remoteDataManager.loginUser(username: username, password: password, completion: completion)
    }
    
    func saveUserLogged(user: UserLogged, completion: @escaping (Result<Bool, Error>) -> ()) {
        localDataManager.saveUserLogged(user: user, completion: completion)
    }
    
    func getUserLogged(completion: @escaping (Result<UserLogged?, Error>) -> ()) {
        localDataManager.getUserLogged(completion: completion)
    }
    
    func deleteUserLogged(completion: @escaping (Result<Bool, Error>) -> ()) {
        localDataManager.deleteUserLogged(completion: completion)
    }
    
    func registerUser(email: String, username: String, password: String, completion: @escaping (Result<RegisterUserResponse?, Error>) -> ()) {
        remoteDataManager.registerUser(email:email, username: username, password: password, completion: completion)
    }
}
