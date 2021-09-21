import Foundation

struct UserAlbums: Codable {
    var albumsList: [Album]
    enum CodingKeys: String, CodingKey {
        case albumsList = "data"
    }
}

struct Album: Codable {
    var id: String
    var name: String
}

struct AlbumPicture: Codable {
    var data: AlbumUrl
}

struct AlbumUrl: Codable {
    var url: String
}
