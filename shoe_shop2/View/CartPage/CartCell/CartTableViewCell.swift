import UIKit

class CartTableViewCell: UITableViewCell {
    
    static let identifier = "customCartTableViewCell"
    @IBOutlet weak var shoeImage: UIImageView!
    @IBOutlet weak var shoeName: UILabel!
    @IBOutlet weak var shoePrice: UILabel!
    @IBOutlet weak var shoeQuantity: UILabel!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    //Delegate property as weak
    @IBOutlet weak var checkBox: CheckBox!
    weak var cellDelegate: CartTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapQuantity = UITapGestureRecognizer(target: self, action: #selector(handleQuantityTap))
        shoeQuantity.addGestureRecognizer(tapQuantity)
        let tapCheckBox = UITapGestureRecognizer(target: self, action: #selector(handleCheckBoxTap))
        checkBox.addGestureRecognizer(tapCheckBox)
        shoeImage.roundedAllSide(with: 8)
        btnPlus.roundedAllSide(with: 2)
        btnMinus.roundedAllSide(with: 2)
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }
    
    func setData(cartItem: Cart) {
        if cartItem.isSelected {
            checkBox.setImage( UIImage(named: "ic_checked"), for: UIControl.State.normal)
        } else {
            checkBox.setImage( UIImage(named: "ic_unchecked"), for: UIControl.State.normal)
        }
        shoeName.text = cartItem.shoeName
        shoeQuantity.text = String(cartItem.shoeQuantity)
        shoePrice.text = "\(cartItem.shoePrice)$"
        if let imageName = cartItem.shoeImage ,let image = getSavedImage(named: imageName) {
            shoeImage.image = image
        }
    }
    
    @IBAction func btnPlusAction(_ sender: UIButton) {
        cellDelegate?.pressButtonPlus(cell: self, didTapped: sender)
    }
    @IBAction func btnMinusAction(_ sender: UIButton) {
        cellDelegate?.pressButtonMinus(cell: self, didTapped: sender)
    }
    
    @objc func handleCheckBoxTap(){
        cellDelegate?.pressCheckBox(cell: self)
        //        self.imgCheckBox.image = self.imgCheckBox.image == UIImage(named: "ic_checked") ? UIImage(named: "ic_unchecked") : UIImage(named: "ic_checked")
    }
    
    @objc func handleQuantityTap(){
        cellDelegate?.pressLabelQuantity(cell: self)
    }
}

//MARK: - Protocol declaration
protocol CartTableViewCellDelegate: AnyObject {
    func pressLabelQuantity(cell: CartTableViewCell)
    func pressCheckBox(cell: CartTableViewCell)
    func pressButtonPlus(cell: CartTableViewCell, didTapped button:UIButton?)
    func pressButtonMinus(cell: CartTableViewCell, didTapped button:UIButton?)
}
