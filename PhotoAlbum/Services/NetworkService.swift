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
                print(error)
            }
        }
    }

    func fetchAlbumPicture(from id: String, completion: @escaping (Data?) -> Void) {
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
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
