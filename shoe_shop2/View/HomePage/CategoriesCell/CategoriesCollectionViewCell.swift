//
//  CategoriesCollectionViewCell.swift
//  shoes_shop_ios
//
//  Created by tientran on 05/05/2021.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
 
    override var isHighlighted: Bool {
          didSet {
              if self.isHighlighted {
                containerView.backgroundColor = UIColor(named: ColorTheme.backgroundButton)
                textLabel.textColor = .white
              } else {
                containerView.backgroundColor = .white
                textLabel.textColor = UIColor(named: ColorTheme.middleGrayBackground)
              }
          }
      }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        containerView.addGestureRecognizer(tap)

    }
    
    override func layoutSubviews() {
        containerView.roundedAllSide(with: 22.5)
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @objc func handleTap(){
        isHighlighted = !isHighlighted
    }
    
    // a
    
  

}
