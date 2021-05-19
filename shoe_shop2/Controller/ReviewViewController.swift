//
//  ReviewViewController.swift
//  shoe_shop2
//
//  Created by Nguyen Thanh Phuc on 5/12/21.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

@objc protocol ReviewViewControllerDelegate {
    @objc optional func shouldLogin()
}

class ReviewViewController: UIViewController {
    
    var reviewArray: [Review]?
    var productID: String?
    var delegate: ReviewViewControllerDelegate?
    
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "ReviewCell")
        fechDataFirebase()
    }
    
    func fechDataFirebase() {
        guard let id = productID else {
            return
        }
        FirebaseManager.shared.fetchReviewData(reviewId: id) { (data) in
            DispatchQueue.main.async {
                self.reviewArray = data
                self.myTableView.reloadData()
            }
        }
    }
}

extension ReviewViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewArray?.count ?? 0
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell") as! ReviewTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.reviewContentLabel.text = reviewArray![indexPath.row].comment
        cell.userId = reviewArray![indexPath.row].userID
        cell.fetchUserImage()
        cell.handleStar(indexStar: reviewArray![indexPath.row].star)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = UINib(nibName: "CustomHeaderTableView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CustomHeaderTableView
        viewHeader.addTapGestureForStarView()
        viewHeader.delegate = self
        return viewHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
}

extension ReviewViewController: CustomHeaderTableViewDelegate {
    func startDidSelect(selectedIndex: Int) {
        guard (Auth.auth().currentUser?.uid) != nil else {
            let alert = UIAlertController(title: "Notification", message: "Please Login Before Review !", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Login", style: .default, handler: {_ in
                self.delegate?.shouldLogin?()
                self.dismiss(animated: true)
            }))
            present(alert, animated: true, completion: nil)
            return
        }
        let detailReviewVC = UIStoryboard(name: "ReviewDetailPage", bundle: nil).instantiateViewController(withIdentifier: "ReviewDetail") as! ReviewDetailViewController
        detailReviewVC.initStart(index: selectedIndex)
        detailReviewVC.modalPresentationStyle = .custom
        detailReviewVC.transitioningDelegate = self
        self.present(detailReviewVC, animated: true, completion: nil)
        guard let idShoes = productID else {
            return
        }
        detailReviewVC.productDetailID = idShoes
       
    }
}

extension ReviewViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return CustomPresentation(presentedViewController: presented, presenting: presenting)
    }
}
