import Foundation
import UIKit
import RealmSwift

///[EN]Protocol which consist field for identification Human /[RU]Протокол человека. Содержит минимально необходимые параметры для идентификации пользователя
protocol Human: Entity {
    
    //MARK: - Variables
    
    ///[EN]Identification Number of the Person /[RU]ИД пользователя
    var id : Int          { get }
    
    ///[EN]Second name of the Person /[RU]Фамилия пользователя
    var lastName: String  { get }
    
    ///[EN]Return Name and Surname of the Person /[RU]Возвращает Имя(name) и Фамилию(surname) человека
    var fullName: String  { get }
    
    ///[EN]Return Surname and Name of the Person /[RU]Возвращает Фамилию(surname) и Имя(name) человека
    var fullSurname: String { get }
    
}

extension Human {
    var fullName: String { get { return name + " " + lastName} }
    var fullSurname: String { get { return lastName + " " + name } }
}
