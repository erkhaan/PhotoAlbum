import Foundation
import FBSDKCoreKit
import Alamofire

class NetworkService {

    // MARK: Properties

    private var graphUrl = "https://graph.facebook.com/v12.0/"

    // MARK: Methods

    func fetchAlbums(completion: @escaping ([Album]) -> Void) {
        guard let token = AccessToken.current?.tokenString else {
            print("Token expired")
            return
        }
        guard let url = URL(string: graphUrl + "me/albums?access_token=\(token)") else {
            print("Wrong albums url")
            return
        }
        AF.request(url).responseDecodable(of: UserAlbums.self) { response in
            switch response.result {
            case .success(let value):
                completion(value.albumsList)
            case .failure(let error):
                print("Error decoding data: \(error)")
            }
        }
    }

    func fetchPicture(from id: String, completion: @escaping (UIImage) -> Void) {
        guard let token = AccessToken.current?.tokenString else {
            print("Token expired")
            return
        }
        guard let url = URL(string: graphUrl + "\(id)/picture?access_token=\(token)") else {
            print("Wrong albums picture url")
            return
        }
        AF.request(url).response { response in
            switch response.result {
            case .success(let value):
                guard let data = value else {
                    print("Data is nil")
                    return
                }
                if let image = UIImage(data: data) {
                    completion(image)
                }
            case .failure(let error):
                print("Error fetching image: \(error)")
            }
        }
    }

    func fetchPhotos(from id: String, completion: @escaping ([Photo]) -> Void) {
        guard let token = AccessToken.current?.tokenString else {
            print("Token expired")
            return
        }
        guard let url = URL(string: graphUrl + "\(id)/photos?access_token=\(token)") else {
            print("Wrong photos url")
            return
        }
        AF.request(url).responseDecodable(of: AlbumPhotos.self) { response in
            switch response.result {
            case .success(let value):
                completion(value.data)
            case .failure(let error):
                print("Error decoding data: \(error)")
            }
        }
    }

    func fetchPhotoNode(from id: String, completion: @escaping (PhotoNode) -> Void) {
        guard let token = AccessToken.current?.tokenString else {
            print("Token expired")
            return
        }
        guard let url = URL(string: graphUrl + "\(id)?fields=id,height,width,created_time,images&access_token=\(token)") else {
            print("Wrong photo node url")
            return
        }
        AF.request(url).responseDecodable(of: PhotoNode.self) { response in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print("Error decoding photo node: \(error)")
            }
        }
    }

    func fetchImage(from imageUrl: String, completion: @escaping (UIImage) -> Void) {
        guard let url = URL(string: imageUrl) else {
            print("Wrong image url")
            return
        }
        AF.request(url).response { response in
            switch response.result {
            case .success(let value):
                guard let data = value else {
                    print("Data is nil")
                    return
                }
                if let image = UIImage(data: data) {
                    completion(image)
                }
            case .failure(let error):
                print("Error fetching image: \(error)")
            }
        }
    }
}
