//
//  DiscourseClientRemoteDataManager.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Protocolo que contiene todas las llamadas remotas de la app
protocol DiscourseClientRemoteDataManager {
    func fetchAllTopics(nextPage: String?, completion: @escaping (Result<LatestTopicsResponse?, Error>) -> ())
    
    func fetchTopic(id: Int, completion: @escaping (Result<SingleTopicResponse?, Error>) -> ())
    func fetchSpecificPosts(of topicId: Int, postIds: [Int], completion: @escaping (Result<SpecificPostsResponse?, Error>) -> ())
    func addTopic(title: String, raw: String, createdAt: String, completion: @escaping (Result<AddNewTopicResponse?, Error>) -> ())
    func deleteTopic(id: Int, completion: @escaping (Result<DeleteTopicResponse?, Error>) -> ())
    
    func addPost(topicId: Int, content: String, completion: @escaping (Result<AddNewPostResponse?, Error>) -> ())
    
    func fetchCategories(completion: @escaping (Result<CategoriesResponse?, Error>) -> ())
    
    func fetchAllUsers(completion: @escaping (Result<UsersResponse?, Error>) -> ())
    
    func fetchUser(username: String, completion: @escaping (Result<UserDetailResponse?, Error>) -> ())
    func updateNameUser(username: String, name: String, completion: @escaping (Result<UpdateNameUserResponse?, Error>) -> ())
    
    func loginUser(username: String, password: String, completion: @escaping (Result<UserDetailResponse?, Error>) -> ())
    func registerUser(email: String, username: String, password: String, completion: @escaping (Result<RegisterUserResponse?, Error>) -> ())
}
