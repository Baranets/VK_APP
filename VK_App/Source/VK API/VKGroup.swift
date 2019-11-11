import Foundation
import SwiftyJSON
import Alamofire

///[EN]Class is designed to work for VK API. Especially with Groups /[RU]Класс предназначен для работы с API VK. Особенно с Группами
class VKGroup: VKConfiguration {
    
    func get(userId: String?, completion: @escaping ([Group]) -> Void) {
        
        var urlComponents = self.urlComponents
        
        urlComponents.path   = "/method/groups.get"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "extended", value: "1")
        ] + defaultQueryItems
        
        if userId != nil {
            urlComponents.queryItems?.append(URLQueryItem(name: "user_id", value: userId ?? ""))
        }

        Alamofire.request(urlComponents.url!).responseData { response in
            switch response.result {
            case .success:
                guard let data = response.value else {
                    return
                }
                do {
                    let json = try JSON(data: data)
                    let groups = json["response"]["items"].compactMap { Group(json: $0.1) }

                    completion(groups)
                } catch {
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    ///Returns a list of groups for the specified search request
    func search(by search: String?, completion: @escaping ([Group]) -> Void) {

        //[EN]Create a URL request /[RU]Формируем URL запрос
        var urlComponents = self.urlComponents
        
        urlComponents.path   = "/method/groups.search"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: search ?? "")
        ] + defaultQueryItems
        
        Alamofire.request(urlComponents.url!).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let json = try JSON(data: data)
                    let groups = json["response"]["items"].compactMap { Group(json: $0.1) }
                    completion(groups)
                } catch {
                    return
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

        Alamofire.request(urlComponents.url!).responseData { response in
            switch response.result {
            case .success: completion()
            case .failure: break
            }
        }
    }
    
    ///Send the request for "Join to the Group"
    func join(group_id: Int) {
        guard group_id >= 1 else { return }
        
        //[EN]Create a URL request /[RU]Формируем URL запрос
        var urlComponents = self.urlComponents
        
        urlComponents.path   = "/method/groups.join"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "group_id", value: String(group_id))
        ] + defaultQueryItems
        
        //Treatment of the JSON
        Alamofire.request(urlComponents.url!).responseData { response in
            switch response.result {
            case .success: break
            case .failure: break
            }
        }
    }
}
