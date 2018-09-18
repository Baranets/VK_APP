
import UIKit

private let reuseIdentifier = "Cell"

class ImagesFriendViewController: UICollectionViewController {

    var user: User = User()
    var userImages: UserImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        VK_API().getUserPhotos(owner_id: nil)

        //Добавить уже скаченную картинку Автарку
        userImages = UserImage(user: user, images: [user.avatar])
        
        //Во второстепенном потоке скачать остальные изображения пользователя
        ///TODO: Реализовать в последующих версиях
        userImages?.downloadImages()
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionUS", for: indexPath)
    
        let imageUsers = cell.viewWithTag(1) as! UIImageView
        imageUsers.image = userImages?.images[indexPath.row] ?? nil
        // Configure the cell
    
        return cell
    }

}
