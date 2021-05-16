import UIKit
import FirebaseDatabase
import SkeletonView
import SDWebImage

class HomepageViewController: UIViewController {

    // MARK: - juut for test firebase
    private var ref = Database.database().reference()

    // MARK: - Properties
    @IBOutlet weak var categoryCollection: UICollectionView!
    @IBOutlet weak var productCollection: UICollectionView!
    @IBOutlet weak var lastestProductCollection: UICollectionView!
    @IBOutlet weak var searchButton: UIButton!
    
    var categoriesList : [CategoryModel] = []
    var productList : [ProductModel] = []
    var lastestProductList : [ProductModel] = []
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollecions()
        configureNavBackground()
    
        // MARK: - Fetch data in firebase funcs
        fetchCategory()
        fetchProduct()
        fetchLastestProduct()
    }
    
    override func viewWillLayoutSubviews() {
        searchButton.roundedAllSide(with: 8)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Helper
    private func configureNavBackground(){
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func configureCollecions(){
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        categoryCollection.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")
        
        productCollection.delegate = self
        productCollection.dataSource = self
        productCollection.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "productCell")

        lastestProductCollection.delegate = self
        lastestProductCollection.dataSource = self
        lastestProductCollection.register(UINib(nibName: "LastestProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "lastestProductCell")
        
        categoryCollection.showsVerticalScrollIndicator = false
        categoryCollection.showsHorizontalScrollIndicator = false
        productCollection.showsVerticalScrollIndicator = false
        productCollection.showsHorizontalScrollIndicator = false
        lastestProductCollection.showsVerticalScrollIndicator = false
        lastestProductCollection.showsHorizontalScrollIndicator = false
    }
    
    // MARK: - Firebase func
    func fetchCategory()  {
        FirebaseManager.shared.fetchProductCategory { dataSnapshot in
            if let data = dataSnapshot.value as? [String: AnyObject] {
                data.forEach { (key : String, value: AnyObject) in
                    
                    self.categoriesList.append(FirebaseManager.shared.parseCategorModel(id: key ,object: value))
                    DispatchQueue.main.async {
                        self.categoryCollection.reloadData()
                    }
                }
            }
        }
    }
    
    func fetchProduct() {

        FirebaseManager.shared.fetchProduct { dataSnapshot in
            if let data = dataSnapshot.value as? [String: AnyObject] {
                data.forEach { (key : String, value: AnyObject) in
                    self.productList.append(FirebaseManager.shared.parseProductModel(id: key, object: value))
                    DispatchQueue.main.async {
                        
                        self.productList.sort { first, second in
                            first.productName < second.productName
                        }
                        self.productCollection.reloadData()
                    }
                }
            }
        }
    }
    
    func fetchLastestProduct() {

        FirebaseManager.shared.fetchProductLastest { dataSnapshot in
            if let data = dataSnapshot.value as? [String: AnyObject] {
                data.forEach { (key : String, value: AnyObject) in
                    self.lastestProductList.append(FirebaseManager.shared.parseProductModel(id: key, object: value))
                    DispatchQueue.main.async {
                        self.lastestProductCollection.reloadData()
                    }
                }
            }
        }
    }
}

// MARK: - UICollectionViewDelegate , UICollectionViewDataSource
extension HomepageViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.categoryCollection {
            return categoriesList.count
        }

        if collectionView == self.productCollection {
            return productList.count
        }

        return lastestProductList.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.productCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
            cell.configureCell(product: productList[indexPath.row])
            return cell
        }

        if collectionView == self.lastestProductCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lastestProductCell", for: indexPath) as! LastestProductCollectionViewCell
            cell.customInitCell(product: lastestProductList[indexPath.row])
       
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoriesCollectionViewCell
        
        cell.textLabel.text =  categoriesList[indexPath.row].name
    
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.productCollection || collectionView == self.lastestProductCollection{
            
            let detailVC = UIStoryboard(name: "DetailProduct", bundle: nil).instantiateViewController(identifier: "detailViewController") as! DetailProductViewController

            if collectionView == productCollection {
                detailVC.product = productList[indexPath.row]
            }
            
            if collectionView == lastestProductCollection {
                detailVC.product = lastestProductList[indexPath.row]

            }
            navigationController?.pushViewController(detailVC, animated: true)
            
//            let id = productList[indexPath.row].id
//            FirebaseManager.shared.fectProductColor(idPath: id) { dataSnapshot in

//                if let data = dataSnapshot.value as? [String: AnyObject] {
//                    data.forEach { (key : String, value: AnyObject) in
//                        print(key)
//                        FirebaseManager.shared.parseProductColorModel(idProductCategory: id, id : key, object: value)
//                    }
//                }
//            }
        
        }
    }
    
}

extension HomepageViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.productCollection {
            return CGSize(width: 240, height: 300)
        }
        
        if collectionView == self.lastestProductCollection {
            return CGSize(width: 150, height: 150)
        }
        
        return CGSize(width: 120, height: 45)
        
    }
    
}
