//Protocol declaration
protocol CartTableViewCellDelegate: class {
    func pressLabelQuantity(cell: CartTableViewCell)
    func pressButtonPlus(cell: CartTableViewCell, didTapped button:UIButton?)
    func pressButtonMinus(cell: CartTableViewCell, didTapped button:UIButton?)
}

import UIKit

class CartTableViewCell: UITableViewCell {

    static let identifier = "customCartTableViewCell"
    @IBOutlet weak var imageShoe: UIImageView!
    @IBOutlet weak var nameShoe: UILabel!
    @IBOutlet weak var priceShoe: UILabel!
    @IBOutlet weak var quantityShoe: UILabel!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    //Delegate property as weak
    weak var cellDelegate: CartTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleQuantityTap))
        quantityShoe.addGestureRecognizer(tap)
        imageShoe.roundedAllSide(with: 8)
        btnPlus.roundedAllSide(with: 2)
        btnMinus.roundedAllSide(with: 2)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(cartItem: Cart?) {
        
    }
    
    @IBAction func btnPlusAction(_ sender: UIButton) {
        cellDelegate?.pressButtonPlus(cell: self, didTapped: sender)
    }
    @IBAction func btnMinusAction(_ sender: UIButton) {
        cellDelegate?.pressButtonMinus(cell: self, didTapped: sender)
    }
    
    @objc func handleQuantityTap(){
        cellDelegate?.pressLabelQuantity(cell: self)
    }

}
