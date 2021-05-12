//
//  HomepageViewController.swift
//  shoe_shop2
//
//  Created by Nguyen Thanh Phuc on 5/7/21.
//

import UIKit

class HomepageViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var categoryCollection: UICollectionView!
    @IBOutlet weak var productCollection: UICollectionView!
    @IBOutlet weak var lastestProductCollection: UICollectionView!
    @IBOutlet weak var searchButton: UIButton!
    
    let categoriesList = ["Nike", "Pandas", "Adias", "Madda", "Chenny", "Jimroki"]
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollecions()
        configureNavBackground()
        
    }
    
    override func viewWillLayoutSubviews() {
        searchButton.roundedAllSide(with: 8)
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
}

// MARK: - UICollectionViewDelegate , UICollectionViewDataSource
extension HomepageViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.productCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell

            return cell
        }

        if collectionView == self.lastestProductCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lastestProductCell", for: indexPath) as! LastestProductCollectionViewCell
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoriesCollectionViewCell
    
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.productCollection || collectionView == self.lastestProductCollection{
            
            let modifiedVC = UIStoryboard(name: "DetailProduct", bundle: nil).instantiateViewController(identifier: "detailViewController") as! DetailProductViewController
            
            navigationController?.pushViewController(modifiedVC, animated: true)
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
