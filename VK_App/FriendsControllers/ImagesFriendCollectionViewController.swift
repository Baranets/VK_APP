
import UIKit

private let reuseIdentifier = "Cell"

class ImagesFriendViewController: UICollectionViewController {

    //MARK: - UI Objects

    @IBOutlet var collectionview: UICollectionView!
    
    //MARK: - Variables

    var user: User?
    var userImages = [UserPhoto]()
    var photoCache = NSCache<AnyObject, AnyObject>()
    
    //MARK: - View Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        VK_User().getUserPhotos(owner_id: String(user!.id), completion: { [weak self] userPhotos in
            self?.userImages = userPhotos
            self?.collectionview.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userImages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionUS", for: indexPath)
    
        guard let imageUsers = cell.viewWithTag(1) as? UIImageView else { return cell }
        
        let userImage = userImages[indexPath.row]
        
        if let imageFromCache = photoCache.object(forKey: userImage.url as AnyObject) as? UIImage {
            imageUsers.image = imageFromCache
        } else {
            imageUsers.downloadPhoto(fromURL: userImage.url, imageCache: photoCache)
        }
    
        return cell
    }

}
