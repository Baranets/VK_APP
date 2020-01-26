import UIKit
import AlamofireImage

class ImagesFriendViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    //MARK: - UI Objects
    
    //MARK: - Variables

    var user: VKFriend?
    
    var images = [VKPhoto]()
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.invalidateLayout()
    }
    
    //MARK: - View Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        VKPhotos().get(ownerId: user!.id, completion: { [weak self] response in
            self?.images = response.response.items
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
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionUS", for: indexPath)
    
        guard let imageUsers = cell.viewWithTag(1) as? UIImageView else { return cell }

        let image = images[indexPath.row]
        
        guard let url = image.sizes.first?.photoURL else { return cell }
        imageUsers.af_setImage(withURL: url, placeholderImage: UIImage(), progressQueue: .global(), imageTransition: UIImageView.ImageTransition.crossDissolve(0.2), runImageTransitionIfCached: false)
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 3) - 1
        return CGSize(width: width, height: width)
    }
    
}

