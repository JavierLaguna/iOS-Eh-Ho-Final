import Foundation

// Puedes echar un vistazo en https://docs.discourse.org

struct SingleTopicResponse: Decodable {
    
    let topic: Topic
    let details: TopicDetails
    let posts: Posts
    let allPostIds: [Int]
    
    enum CodingKeys: String, CodingKey {
        
        case topic, details, posts
        case postStream = "post_stream"
        case allPostIds = "stream"
    }
    
    init(from decoder: Decoder) throws {
        let rootObject = try decoder.singleValueContainer()
        topic = try rootObject.decode(Topic.self)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        details = try container.decode(TopicDetails.self, forKey: .details)
        
        let postStreamContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .postStream)
        posts = try postStreamContainer.decode(Posts.self, forKey: .posts)
        allPostIds = try postStreamContainer.decode([Int].self, forKey: .allPostIds)
    }
}
