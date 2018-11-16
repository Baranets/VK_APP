import Foundation
import Alamofire
import SwiftyJSON

///[EN]Class is designed to work for VK API. Can store information about token of the user /[RU]Класс предназначен для работы с API VK. Может хранить в себе информацию о токене пользователя
class VK_API {
    
    ///[EN]Variable store the token of the authorized user /[RU]Переменная хранит token залогиненного пользователя
    static var globalToken: String?
    
    ///[EN]Variable store version of the API /[RU]Переменная хранит версию API
    let version = "5.87"
    
    ///[EN]Function returns URL request with authorization page /[RU]Функция возвращает URL запрос с отображением страницы аунтификации
    func requestLoginView() -> URLRequest {
        //[EN] /[RU]Формирование URL запроса
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
    
    ///[EN]Return token of the user /[RU] Возвращает токен пользователя
    func getToken(fragment: String) -> String? {
        let params = fragment.components(separatedBy: "&").map { $0.components(separatedBy: "=") }.reduce([String: String]()) { result, param in
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
