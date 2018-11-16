import Foundation
import SwiftyJSON
import Alamofire

///[EN]Class is designed to work for VK API. Especially with Groups /[RU]Класс предназначен для работы с API VK. Особенно с Группами
class VK_Group: VK_API {
    
    ///[EN]Return list of the Groups specified user (if the owner_id == nil then return the list of the groups of the logined user) /[RU]Возвращает Список групп указанного пользователя (если входной параметр nil - используется ИД залогиненного пользователя)
    func getUserGroups(user_id: String?, completion: @escaping ([Group]) -> Void) {
        
        //[EN]Create a URL request /[RU]Формируем URL запрос
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host   = "api.vk.com"
        urlComponents.path   = "/method/groups.get"
        urlComponents.queryItems = [

            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "offset", value: "5"),
            URLQueryItem(name: "count", value: "0"),
            URLQueryItem(name: "access_token", value: VK_API.globalToken),
            URLQueryItem(name: "v", value: version)
        ]
        //[EN]Optionaly user id, probability to get groups of the user /[RU]Опциональное ИД пользователся, для возможности получения групп пользователей
        if user_id != nil {
            urlComponents.queryItems?.append(URLQueryItem(name: "user_id", value: user_id ?? ""))
        }

        //[EN]Treatment of the JSON /[RU]Обработка JSON
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
    
    ///[EN]Returns a list of groups for the specified search request/[RU]Возвращает список групп по указанному пользователем поисковому запросу
    func getSearchGroups(by search: String?, completion: @escaping ([Group]) -> Void) {

        //[EN]Create a URL request /[RU]Формируем URL запрос
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host   = "api.vk.com"
        urlComponents.path   = "/method/groups.search"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: search ?? ""),
            URLQueryItem(name: "access_token", value: VK_API.globalToken),
            URLQueryItem(name: "v", value: version)
        ]
        
        //[EN]Treatment of the JSON /[RU]Обработка JSON
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
    
    ///[EN]Send the request for "leave the Group" /[RU]Отправляет запрос "покинуть сообщество"
    func leaveGroup(byGroupID group_id: Int) {
        guard group_id >= 1 else { return }
        
        //[EN]Create a URL request /[RU]Формируем URL запрос
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host   = "api.vk.com"
        urlComponents.path   = "/method/groups.leave"
        urlComponents.queryItems = [
            URLQueryItem(name: "group_id", value: String(group_id)),
            URLQueryItem(name: "access_token", value: VK_API.globalToken),
            URLQueryItem(name: "v", value: version)
        ]

        //[EN]Treatment of the JSON /[RU]Обработка JSON
        Alamofire.request(urlComponents.url!).responseData { response in
            switch response.result {
            case .success: break
            case .failure: break
            }
        }
    }
    
    ///[EN]Send the request for "Join to the Group" /[RU]Отправляет запрос "вступить в сообщество"
    func joinGroup(byGroupID group_id: Int) {
        guard group_id >= 1 else { return }
        
        //[EN]Create a URL request /[RU]Формируем URL запрос
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host   = "api.vk.com"
        urlComponents.path   = "/method/groups.join"
        urlComponents.queryItems = [
            URLQueryItem(name: "group_id", value: String(group_id)),
            URLQueryItem(name: "access_token", value: VK_API.globalToken),
            URLQueryItem(name: "v", value: version)
        ]
        
        //[EN]Treatment of the JSON /[RU]Обработка JSON
        Alamofire.request(urlComponents.url!).responseData { response in
            switch response.result {
            case .success: break
            case .failure: break
            }
        }
    }
}
