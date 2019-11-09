import Foundation
import SwiftyJSON
import Alamofire

class VKFriends: VKConfiguration {
    
    func get(user_id: String?, completion: @escaping ([User]) -> Void) {
        var urlComponents = self.urlComponents
        
        urlComponents.path   = "/method/friends.get"
                
        urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: user_id ?? ""),
            URLQueryItem(name: "fields", value: "city,domain,photo")
        ] + defaultQueryItems
        
        Alamofire.request(urlComponents.url!).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let json = try JSON(data: data)
                    let users = json["response"]["items"].compactMap { User(json: $0.1) }
                    completion(users)
                } catch {
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
