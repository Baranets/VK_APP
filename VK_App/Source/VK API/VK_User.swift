import Foundation
import SwiftyJSON
import Alamofire

///[EN]Class is designed to work for VK API. Especially with Users /[RU]Класс предназначен для работы с API VK. Особенно с Пользователями
class VK_User: VK_API {
    
    ///[EN]Return list of the Friends of the User. If the user_id == nil return list of the Friends of the Logined User /[RU]Возвращает список друзей пользователя. В случае если user_id == nil возвращается список друзей залогинненого пользователя
    func getUserFriendList(user_id: String?, completion: @escaping ([User]?) -> Void) {
        
        //[EN]Create a URL request /[RU]Формируем URL запрос
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host   = "api.vk.com"
        urlComponents.path   = "/method/friends.get"
        
        urlComponents.queryItems = [
            //[EN]Optionaly user id, probability to get friends of the user /[RU]Опциональное ИД пользователся, для возможности получения списка друзей пользователя
            URLQueryItem(name: "user_id", value: user_id ?? ""),
            URLQueryItem(name: "access_token", value: VK_API.globalToken),
            URLQueryItem(name: "v", value: version),
            URLQueryItem(name: "fields", value: "city,domain,photo")
        ]
        
        //[EN]Treatment of the JSON /[RU]Обработка JSON
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
            case .failure(_):
                completion(nil)
                return
            }
        }
    }
    
    ///[EN]Return list of the photos specified user (if the owner_id == nil then return the list of the photos of the logined user) /[RU]Возвращает список фотографий указанного пользователя (если входной параметр nil - используется ИД залогиненного пользователя)
    func getUserPhotos(owner_id: String?, completion: @escaping ([UserPhoto]) -> Void) {
        
        //[EN]Create a URL request /[RU]Формируем URL запрос
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host   = "api.vk.com"
        urlComponents.path   = "/method/photos.get"
        
        urlComponents.queryItems = [
            //[EN]Optionaly user id, probability to get photos of the user /[RU]Опциональное ИД пользователся, для возможности получения фото друзей пользователя
            URLQueryItem(name: "owner_id", value: owner_id ?? ""),
            URLQueryItem(name: "album_id", value: "profile"),
            URLQueryItem(name: "access_token", value: VK_API.globalToken),
            URLQueryItem(name: "v", value: version)
            
        ]
        
        //[EN]Treatment of the JSON /[RU]Обработка JSON
        Alamofire.request(urlComponents.url!).responseData { response in
            guard let data = response.value else {
                return
            }
            do {
                let json = try JSON(data: data)
                let userPhotos = json["response"]["items"].compactMap { UserPhoto(json: $0.1) }
                completion(userPhotos)
            } catch {
                return
            }
        }
    }
    
}
