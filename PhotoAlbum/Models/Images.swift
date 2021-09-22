import Foundation

struct PhotoNode: Codable {
    let id: String
    let height, width: Int
    let createdTime: String
    let images: [Image]

    enum CodingKeys: String, CodingKey {
        case id, height, width
        case createdTime = "created_time"
        case images
    }
}

struct Image: Codable {
    let height: Int
    let url: String
    let width: Int

    enum CodingKeys: String, CodingKey {
        case height, width
        case url = "source"
    }
}
