import Foundation
import Alamofire

///[EN]Class is designed to work for VK API. Especially with Groups /[RU]Класс предназначен для работы с API VK. Особенно с Группами
class VKGroupRequest: VKConfiguration {
    
    func get(by userId: Int?, completion: @escaping (VKGroupGetResponse) -> Void) {
        
        var urlComponents = self.urlComponents
        
        urlComponents.path   = "/method/groups.get"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "extended", value: "1")
        ] + defaultQueryItems
        
        if let userId = userId {
            urlComponents.queryItems?.append(URLQueryItem(name: "user_id", value: String(userId)))
        }

        AF.request(urlComponents.url!).responseData(queue: dispatchQueue) { response in
            switch response.result {
            case .success (let data):
                do {
                    let response = try JSONDecoder().decode(VKGroupGetResponse.self, from: data)

                    completion(response)
                } catch let error {
                    print(error)
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error)
                print(error.localizedDescription)
            }
        }
    }
    
    ///Returns a list of groups for the specified search request
    func search(by search: String?, completion: @escaping (VKGroupGetResponse) -> Void) {

        //[EN]Create a URL request /[RU]Формируем URL запрос
        var urlComponents = self.urlComponents
        
        urlComponents.path   = "/method/groups.search"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: search ?? "")
        ] + defaultQueryItems
        
        AF.request(urlComponents.url!).responseData(queue: dispatchQueue) { response in
            switch response.result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(VKGroupGetResponse.self, from: data)

                    completion(response)
                } catch let error {
                    print(error)
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    ///Send the request for "leave the Group"
    func leave(groupId: Int, completion: @escaping(() -> Void)) {
        guard groupId >= 1 else { return }
        
        //Create a URL request
        var urlComponents = self.urlComponents
        
        urlComponents.path   = "/method/groups.leave"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "group_id", value: String(groupId))
        ] + defaultQueryItems

        AF.request(urlComponents.url!).responseData { response in
            switch response.result {
            case .success: completion()
            case .failure: break
            }
        }
    }
    
    ///Send the request for "Join to the Group"
    func join(by groupId: Int) {
        guard groupId >= 1 else { return }
        
        //[EN]Create a URL request /[RU]Формируем URL запрос
        var urlComponents = self.urlComponents
        
        urlComponents.path   = "/method/groups.join"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "group_id", value: String(groupId))
        ] + defaultQueryItems
        
        //Treatment of the JSON
        AF.request(urlComponents.url!).responseData { response in
            switch response.result {
            case .success: break
            case .failure: break
            }
        }
    }
}
