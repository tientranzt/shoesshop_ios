//
//  ReviewViewController.swift
//  shoe_shop2
//
//  Created by Nguyen Thanh Phuc on 5/12/21.
//

import UIKit

class ReviewViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "ReviewCell")
    }
    
}

extension ReviewViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell") as! ReviewTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
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
        let detailReviewVC = UIStoryboard(name: "ReviewDetailPage", bundle: nil).instantiateViewController(withIdentifier: "ReviewDetail") as! ReviewDetailViewController
        detailReviewVC.initStart(index: selectedIndex)
        detailReviewVC.modalPresentationStyle = .custom
        detailReviewVC.transitioningDelegate = self
        self.present(detailReviewVC, animated: true, completion: nil)
    }
}

extension ReviewViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return CustomPresentation(presentedViewController: presented, presenting: presenting)
    }
}
