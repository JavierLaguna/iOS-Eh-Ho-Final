//
//  User.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 01/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

typealias Users = [User]

final class User: Object, Codable {
    
    @objc dynamic var id: Int = -1
    @objc dynamic var username: String = ""
    @objc dynamic var name: String?
    @objc dynamic var avatarTemplate: String = ""
    @objc dynamic var email: String?
    @objc dynamic var canEdit: Bool = false
    @objc dynamic var canEditUsername: Bool = false
    @objc dynamic var canEditEmail: Bool = false
    @objc dynamic var canEditName: Bool = false
    @objc dynamic var ignored: Bool = false
    @objc dynamic var muted: Bool = false
    @objc dynamic var lastSeenAt: Date?
    @objc dynamic var moderator: Bool = false
    @objc dynamic var profileViewCount: Int = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case userKey = "user"
        
        case id, username, name, email, ignored, muted, moderator
        case avatarTemplate = "avatar_template"
        case canEdit = "can_edit"
        case canEditUsername = "can_edit_username"
        case canEditEmail = "can_edit_email"
        case canEditName = "can_edit_name"
        case lastSeenAt = "last_seen_at"
        case profileViewCount = "profile_view_count"
    }
    
    required init() {
        super.init()
    }
    
    init(from decoder: Decoder) throws {
        var container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let rootUser = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .userKey) {
            container = rootUser
        }
        
        id = try container.decode(Int.self, forKey: .id)
        username = try container.decode(String.self, forKey: .username)
        avatarTemplate = try container.decode(String.self, forKey: .avatarTemplate)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        canEdit = try container.decodeIfPresent(Bool.self, forKey: .canEdit) ?? false
        canEditUsername = try container.decodeIfPresent(Bool.self, forKey: .canEditUsername) ?? false
        canEditEmail = try container.decodeIfPresent(Bool.self, forKey: .canEditEmail) ?? false
        canEditName = try container.decodeIfPresent(Bool.self, forKey: .canEditName) ?? false
        ignored = try container.decodeIfPresent(Bool.self, forKey: .ignored) ?? false
        muted = try container.decodeIfPresent(Bool.self, forKey: .muted) ?? false
        moderator = try container.decodeIfPresent(Bool.self, forKey: .moderator) ?? false
        profileViewCount = try container.decodeIfPresent(Int.self, forKey: .profileViewCount) ?? 0
        
        if let lastSeenAtString = try container.decodeIfPresent(String.self, forKey: .lastSeenAt) {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            lastSeenAt = formatter.date(from: lastSeenAtString)
        } else {
            lastSeenAt = nil
        }
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(username, forKey: .username)
    }
}
