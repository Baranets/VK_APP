import Foundation
import Alamofire

class VKFriends: VKConfiguration {
    
    let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func get(by userId: Int?, completion: @escaping (VKFriendGetResponse) -> Void) {
        var urlComponents = self.urlComponents
        
        urlComponents.path   = "/method/friends.get"
                
        var stringUserId: String?
        if let userId = userId {
            stringUserId = String(userId)
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: stringUserId ?? ""),
            URLQueryItem(name: "fields", value: "city,domain,photo")
        ] + defaultQueryItems
        
        Alamofire.request(urlComponents.url!).responseData(queue: dispatchQueue) { response in
            switch response.result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(VKFriendGetResponse.self, from: data)
                    completion(response)
                } catch (let error) {
                    print(error)
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error)
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    if let tvc = self.viewController as? UITableViewController {
                        tvc.tableView.refreshControl?.endRefreshing()
                    } else if let cvc = self.viewController as? UICollectionViewController {
                        cvc.collectionView.refreshControl?.endRefreshing()
                    }
                    
                    let alert = AlertBuilder().createAlert(title: "No Internet", message: "Wow")
                    self.viewController.present(alert, animated: true)
                }
            }
        }
    }
    
}
