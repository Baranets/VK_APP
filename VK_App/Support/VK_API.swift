import Foundation
import Alamofire

///Класс предназначен для работы с API VK. Может хранить в себе информацию о токене пользователя и исполнять различные URL запросы
class VK_API {
    
    ///Переменная хранит token залогиненного пользователя
    static var globalToken: String?
    
    ///Переменная хранит версию API
    let version = "5.85"
    
    ///Функция возвращает URL запрос с отображением страницы аунтификации, который в последствии можно использовать в WebView
    func requestLoginView() -> URLRequest {
        //Формирование URL запроса
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host   = "oauth.vk.com"
        urlComponents.path   = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "6695930"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: version)
        ]
        
        return URLRequest(url: urlComponents.url!)
    }
    
    ///Возвращает (на данный момент только печатает) список друзей пользователя. В случае если user_id = nil возвращается список друзей залогинненого пользователя
    func getUserFriendList(user_id: String?) {
        //Формируем URL запрос
        var urlComponents = URLComponents()

        urlComponents.scheme = "https"
        urlComponents.host   = "api.vk.com"
        urlComponents.path   = "/method/friends.get"
        
        urlComponents.queryItems = [
            //Опциональное ИД пользователся, т.к. возможно в будущем необходимоть получения списка друзей -> друзей
            URLQueryItem(name: "user_id", value: user_id ?? ""),
            URLQueryItem(name: "access_token", value: VK_API.globalToken),
            URLQueryItem(name: "v", value: version)
        ]
        
        //Возвращает JSON с id друзей пользователя
        Alamofire.request(urlComponents.url!).responseJSON { response in
            //Печать в консоль полученного JSON
            print(response.value ?? "friendList")
        }
    }
    
    ///Возвращает список фотографий указанного пользователя (если входной параметр nil - используется ИД залогиненного пользователя)
    func getUserPhotos(owner_id: String?) {
        //Формируем URL запрос
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host   = "api.vk.com"
        urlComponents.path   = "/method/photos.getAll"
        
        urlComponents.queryItems = [
            //Опциональное ИД пользователся, т.к. возможно в будущем необходимоть получения фото друзей -> друзей
            URLQueryItem(name: "owner_id", value: owner_id ?? ""),
            URLQueryItem(name: "access_token", value: VK_API.globalToken),
            URLQueryItem(name: "v", value: version)

        ]
        
        Alamofire.request(urlComponents.url!).responseJSON { response in
            //Печать в консоль полученного JSON
            print(response.value ?? "photoList")
        }
    }
    
    ///Возвращает Список групп указанного пользователя (если входной параметр nil - используется ИД залогиненного пользователя)
    func getUserGroups(user_id: String?) {
        //Формируем URL запрос
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host   = "api.vk.com"
        urlComponents.path   = "/method/groups.get"
        
        urlComponents.queryItems = [
            //Опциональное ИД пользователся, т.к. возможно в будущем необходимоть получения групп друзей -> друзей
            URLQueryItem(name: "user_id", value: user_id ?? ""),
            URLQueryItem(name: "access_token", value: VK_API.globalToken),
            URLQueryItem(name: "v", value: version)
            
        ]
        
        Alamofire.request(urlComponents.url!).responseJSON { response in
            //Печать в консоль полученного JSON
            print(response.value ?? "photoList")
        }
    }
    
    ///Возвращает список групп по указанному пользователем поисковому запросу
    func getSearchedGroups(searched: String?) {
        //Формируем URL запрос
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host   = "api.vk.com"
        urlComponents.path   = "/method/groups.search"
        
        urlComponents.queryItems = [
            //Поисковый запрос
            URLQueryItem(name: "q", value: searched ?? ""),
            URLQueryItem(name: "access_token", value: VK_API.globalToken),
            URLQueryItem(name: "v", value: version)
            
        ]
        
        Alamofire.request(urlComponents.url!).responseJSON { response in
            //Печать в консоль полученного JSON
            print(response.value ?? "photoList")
        }
    }
    
    func getToken(fragment: String) -> String? {
        let params = fragment.components(separatedBy: "&").map {$0.components(separatedBy: "=")}.reduce([String: String]()) { result, param in
            var dict = result
            let key = param[0]
            let value = param[1]
            dict[key] = value
            return dict
        }
        let token = params["access_token"]
        VK_API.globalToken = token
        
        return token
    }
    
    
}
