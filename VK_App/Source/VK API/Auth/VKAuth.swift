import Foundation
import Alamofire

///[EN]Class is designed to work for VK API. Can store information about token of the user /[RU]Класс предназначен для работы с API VK. Может хранить в себе информацию о токене пользователя
class VKAuth: VKConfiguration {    
    
    ///[EN]Variable store the token of the authorized user /[RU]Переменная хранит token залогиненного пользователя
    static var token: String?
    
    var host: String {
        return "oauth.vk.com"
    }
        
    ///[EN]Function returns URL request with authorization page /[RU]Функция возвращает URL запрос с отображением страницы аунтификации
    func requestLoginView() -> URLRequest {
        //[EN] /[RU]Формирование URL запроса
        var urlComponents = self.urlComponents
        
        urlComponents.path   = "/authorize"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "6936822"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "1044479"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: apiVersion)
        ]
        
        return URLRequest(url: urlComponents.url!)
    }
    
    func requestLogout() {
        
        var urlComponents = self.urlComponents
        
        urlComponents.path   = "/logout"
        
        AF.request(urlComponents.url!).responseData(completionHandler: { response in
            switch response.result {
            case .success:
                VKAuth.token = nil
                print(response)
            case .failure(let error):
                print(error)
            }
        })
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
        VKAuth.token = token

        return token
    }
    
}
