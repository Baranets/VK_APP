import Foundation
import Alamofire

class VKFriends: VKConfiguration {
    
    func get(by userId: Int?, completion: @escaping (VKFriendGetResponse) -> Void) {
        var urlComponents = self.urlComponents
        
        urlComponents.path   = "/method/friends.get"
                
        var stringUserId: String?
        if let userId = userId {
            stringUserId = String(userId)
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: stringUserId ?? ""),
            URLQueryItem(name: "fields", value: "city,domain,photo")
        ] + defaultQueryItems
        
        Alamofire.request(urlComponents.url!).responseData(queue: dispatchQueue) { response in
            switch response.result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(VKFriendGetResponse.self, from: data)
                    completion(response)
                } catch (let error) {
                    print(error)
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error)
                print(error.localizedDescription)
            }
        }
    }
    
}
