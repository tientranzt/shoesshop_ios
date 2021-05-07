//
//  CellCustomCartTableViewCell.swift
//  shoes_shop_ios
//
//  Created by TrieuLX on 5/5/21.
//

import UIKit

class CellCustomCartTableViewCell: UITableViewCell {

    @IBOutlet weak var imageShoes: UIImageView!
    @IBOutlet weak var nameShoes: UILabel!
    @IBOutlet weak var priceShoes: UILabel!
    @IBOutlet weak var quantityShoes: UILabel!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageShoes.roundedAllSide(with: imageShoes.frame.height/5)
        btnPlus.roundedAllSide(with: btnPlus.frame.height/2)
        btnMinus.roundedAllSide(with: btnMinus.frame.height/2)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
