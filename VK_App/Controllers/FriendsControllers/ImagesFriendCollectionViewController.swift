
import UIKit
import AlamofireImage

private let reuseIdentifier = "Cell"

class ImagesFriendViewController: UICollectionViewController {

    //MARK: - UI Objects

    @IBOutlet var collectionview: UICollectionView!
    
    //MARK: - Variables

    var user: User?
    var userImages = [UserPhoto]()
    let imageCache = AutoPurgingImageCache(
        memoryCapacity: 48 * 1024 * 1024,
        preferredMemoryUsageAfterPurge: 32 * 1024 * 1024
    )
    
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

        let userPhoto = userImages[indexPath.row]
        
        guard let url = URL(string: userPhoto.urlString) else { return cell }
        imageUsers.downloadPhoto(fromURL: url, imageCache: imageCache)
        
    
        return cell
    }

}
