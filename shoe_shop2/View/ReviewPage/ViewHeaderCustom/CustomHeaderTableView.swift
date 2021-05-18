//
//  CustomHeaderTableView.swift
//  shoe_shop2
//
//  Created by Nguyen Thanh Phuc on 5/12/21.
//

import UIKit

@objc protocol CustomHeaderTableViewDelegate:AnyObject {
    @objc optional func startDidSelect(selectedIndex: Int)
}

class CustomHeaderTableView: UIView {
    var star: Int?
    
    @IBOutlet weak var starOneImage: UIImageView?
    @IBOutlet weak var starTwoImage: UIImageView?
    @IBOutlet weak var starThreeImage: UIImageView?
    @IBOutlet weak var starFourImage: UIImageView?
    @IBOutlet weak var starFiveImage: UIImageView?
    
    var delegate: CustomHeaderTableViewDelegate?
    var starArray : [UIImageView?]?
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addTapGestureForStarView() {
        starArray = [starOneImage, starTwoImage, starThreeImage, starFourImage, starFiveImage]
        for image in starArray! {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pressStar(_:)))
            image?.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc func pressStar(_ sender: UITapGestureRecognizer) {
        guard let image = sender.view  else {
            return
        }
        starDidSelect(selectedIndex: image.tag)
        delegate?.startDidSelect?(selectedIndex: image.tag)
    }
    
    func starDidSelect(selectedIndex: Int) {
        for (index, image) in starArray!.enumerated() {
            // khi Image được tô màu
            if index <= selectedIndex {
                image?.image = UIImage(systemName: "star.fill" )
            }
            else{
                // khi Image không được tô màu
                image?.image = UIImage(systemName: "star" )
                
            }
        }
        star = selectedIndex
    }
}
