
import Foundation
import UIKit

protocol UserImageProtocol {
    
    ///Переменная хранит в себе данные о пользователе
    var user: UserProtocol { get }
    ///Коллекция хронящая в себе фотографии пользователя
    var images: [UIImage] { get set }
    
    ///Загружает из сети интернет фотографии пользователя
    func downloadImages()
    
}
