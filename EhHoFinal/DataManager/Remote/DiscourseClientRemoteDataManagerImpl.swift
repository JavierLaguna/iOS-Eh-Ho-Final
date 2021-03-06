//
//  DiscourseClientRemoteDataManagerImpl.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Implementación por defecto del protocolo remoto, en este caso usando SessionAPI
final class DiscourseClientRemoteDataManagerImpl: DiscourseClientRemoteDataManager {
    
    // MARK: Properties
    private let session: SessionAPI
    
    // MARK: Lifecycle
    init(session: SessionAPI) {
        self.session = session
    }
    
    // MARK: Public Functions
    func fetchAllTopics(nextPage: String?, completion: @escaping (Result<LatestTopicsResponse?, Error>) -> ()) {
        let request = LatestTopicsRequest(nextPage: nextPage)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func fetchTopic(id: Int, completion: @escaping (Result<SingleTopicResponse?, Error>) -> ()) {
        let request = SingleTopicRequest(id: id)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func fetchSpecificPosts(of topicId: Int, postIds: [Int], completion: @escaping (Result<SpecificPostsResponse?, Error>) -> ()) {
        let request = SpecificPostsRequest(topicId: topicId, postIds: postIds)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func addTopic(title: String, raw: String, createdAt: String, completion: @escaping (Result<AddNewTopicResponse?, Error>) -> ()) {
        let request = CreateTopicRequest(title: title, raw: raw, createdAt: createdAt)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func deleteTopic(id: Int, completion: @escaping (Result<DeleteTopicResponse?, Error>) -> ()) {
        let request = DeleteTopicRequest(id: id)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func addPost(topicId: Int, content: String, completion: @escaping (Result<AddNewPostResponse?, Error>) -> ()) {
        let request = CreatePostRequest(topicId: topicId, content: content)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func fetchCategories(completion: @escaping (Result<CategoriesResponse?, Error>) -> ()) {
        let request = CategoriesRequest()
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func fetchAllUsers(completion: @escaping (Result<UsersResponse?, Error>) -> ()) {
        let request = UsersRequest()
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func fetchUser(username: String, completion: @escaping (Result<UserDetailResponse?, Error>) -> ()) {
        let request = UserDetailRequest(username: username)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func updateNameUser(username: String, name: String, completion: @escaping (Result<UpdateNameUserResponse?, Error>) -> ()) {
        let request = UpdateNameUserRequest(username: username, name: name)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func loginUser(username: String, password: String, completion: @escaping (Result<UserDetailResponse?, Error>) -> ()) {
        let request = LoginUserRequest(username: username)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func registerUser(email: String, username: String, password: String, completion: @escaping (Result<RegisterUserResponse?, Error>) -> ()) {
        let request = RegisterUserRequest(email:email, username: username, password: password)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
}
