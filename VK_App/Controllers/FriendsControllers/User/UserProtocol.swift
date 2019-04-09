
import Foundation
import UIKit

///Протокол пользователя. Содержит минимально необходимые параметры для идентификации пользователя
protocol Human: Entity {
    
    ///ИД пользователя
    var id : Int          { get }
    ///Фамилия пользователя
    var surname: String   { get }
    ///Возраст пользователя
    var age: Int          { get }
    
    ///Возвращает Фамилию(surname) и Имя(name) пользователя(User)
    func getFullSurname() -> String
    
    ///Возвращает Имя(name) и Фамилию(surname) пользователя(User)
    func getFullName() -> String
    
    ///Загружает аватар пользователя в фоновом режиме
    func downloadAvatar()
}

extension Human {
    
    func getFullSurname() -> String {
        return surname + " " + name
    }
    
    func getFullName() -> String {
        return name + " " + surname
    }
    
}
