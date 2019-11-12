import UIKit
import AlamofireImage

class ImagesFriendViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    //MARK: - UI Objects
    
    //MARK: - Variables

    var user: User?
    var userImages = [Photo]()
    let imageCache = AutoPurgingImageCache(
        memoryCapacity: 16 * 1024 * 1024,
        preferredMemoryUsageAfterPurge: 8 * 1024 * 1024
    )
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.reloadData()
    }
    
    //MARK: - View Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        VKPhotos().get(owner_id: String(user!.id), completion: { [weak self] userPhotos in
            self?.userImages = userPhotos
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
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
        
        guard let url = userPhoto.sizes[0].url else { return cell }
        ImageDownloader.shared.downloadImage(fromURL: url, imageCache: imageCache) { (image) in
            DispatchQueue.main.async {
                imageUsers.image = image
            }
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 3) - 1
        return CGSize(width: width, height: width)
    }
    
}

