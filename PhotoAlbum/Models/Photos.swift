import Foundation

struct AlbumPhotos: Codable {
    let data: [Photo]
}

struct Photo: Codable {
    var id: String
    var name: String
    var uploadDate: String

    enum CodingKeys: String, CodingKey {
        case uploadDate = "created_time"
        case name, id
    }
}
