//
//  AddPostDataManager.swift
//  EhHoFinal
//
//  Created by Javier Laguna on 08/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol AddPostDataManager: class {
    
    func addPost(topicId: Int, content: String, completion: @escaping (Result<AddNewPostResponse?, Error>) -> ())
}
