
import Foundation
import UIKit

class User: UserProtocol {
    
    //MARK: - Variables
    var id: Int
    var name: String
    var surname: String
    var age: Int
    var avatar: UIImage
    
    //MARK: - Functions
    func downloadAvatar() {
        //add new code here
        //TODO: реализовать загрузку аватара пользователя в фоновом режиме
    }
    
    //MARK: - Inits
    ///Дефолтный инциализатор класса
    init() {
        self.id = -1
        self.name = "name"
        self.surname = "surname"
        self.age = -1
        self.avatar = UIImage(named: "user_male")!
    }
    
    ///Инициализация пользователя без указания аватара, используя дефолтное изображение
    init(id: Int, surname: String, name: String, age: Int) {
        self.id = id
        self.surname = surname
        self.name = name
        self.age = age
        self.avatar = UIImage(named: "user_male")!
    }
    
    init(id: Int, surname: String, name: String, age: Int, avatar: UIImage) {
        self.id = id
        self.surname = surname
        self.name = name
        self.age = age
        self.avatar = avatar
    }
    
    
}
