//
//  ReviewDetailViewController.swift
//  shoe_shop2
//
//  Created by Nguyen Thanh Phuc on 5/12/21.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

@objc protocol ReviewDetailViewControllerDelegate {
    @objc optional func confirmReview()
}

class ReviewDetailViewController: UIViewController {
    
    var ref = Database.database().reference()
    
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var reviewTextView: UITextView!
    
    @IBOutlet weak var starView: UIView!
    var star: CustomHeaderTableView!
    var delegate: ReviewDetailViewControllerDelegate?
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    var starArray : [UIImageView?]?
    var selectedStar: Int!
    var countStart: Int = 0
    
    var productDetailID: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewTextView.selectAll(reviewTextView)
        if let range = reviewTextView.selectedTextRange { reviewTextView.replace(range, withText: "") }
        setupViews()
        star.starDidSelect(selectedIndex: selectedStar)
        postButton.roundedAllSide(with: 8)
    }
    
    func initStart(index: Int) {
        selectedStar = index
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    func setupViews() {
        star = UINib(nibName: "CustomHeaderTableView", bundle: .main).instantiate(withOwner: nil, options: nil).first as? CustomHeaderTableView
        star.frame = self.starView.bounds
        star.addTapGestureForStarView()
        self.starView.addSubview(star)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        self.view.addGestureRecognizer(panGesture)
    }
    
    
    @IBAction func pressSubmitFeedBack(_ sender: UIButton) {
        guard let userID = Auth.auth().currentUser?.uid else {
//            let alert = UIAlertController(title: "Notification", message: "Please Login Before Review !", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//            present(alert, animated: true, completion: nil)
            return
        }
        guard let start = star.star else {
            return
        }
        guard let reviewText = reviewTextView.text else {
            return
        }
        guard let productID = productDetailID else {
            return
        }
        FirebaseManager.shared.ref.child("reviews").child(productID).childByAutoId().setValue(["star": start, "userID" :  userID, "comment" : reviewText])
        
        self.navigationController?.popViewController(animated: true)
    }
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        self.view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            if translation.y > self.view.frame.height / 2 {
                // Velocity fast enough to dismiss the uiview
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    
    
}
