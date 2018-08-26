
import Foundation
import UIKit

///Протокол пользователя. Содержит минимально необходимые параметры для идентификации пользователя
protocol UserProtocol {
    
    ///ИД пользователя
    var id : Int          { get }
    ///Имя пользователя
    var name: String      { get }
    ///Фамилия пользователя
    var surname: String   { get }
    ///Возраст пользователя
    var age: Int          { get }
    ///Изображение пользователя (Аватар)
    var avatar: UIImage   { get }
    
    ///Возвращает Фамилию(surname) и Имя(name) пользователя(User)
    func getFullSurname() -> String
    
    ///Возвращает Имя(name) и Фамилию(surname) пользователя(User)
    func getFullName() -> String
    
    ///Загружает аватар пользователя в фоновом режиме
    func downloadAvatar()
}

extension UserProtocol {
    
    func getFullSurname() -> String {
        return surname + " " + name
    }
    
    func getFullName() -> String {
        return name + " " + surname
    }
    
}
