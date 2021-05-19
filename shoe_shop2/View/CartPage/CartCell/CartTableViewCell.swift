import UIKit

class CartTableViewCell: UITableViewCell {
    
    static let identifier = "customCartTableViewCell"
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productQuantity: UILabel!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    //Delegate property as weak
    @IBOutlet weak var checkBox: CheckBox!
    @IBOutlet weak var stackViewPlusMinus: UIStackView!
    weak var cellDelegate: CartTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.stackViewPlusMinus.roundedAllSide(with: 2)
        self.stackViewPlusMinus.borderAllSide(width: 0.2, color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        
        let tapQuantity = UITapGestureRecognizer(target: self, action: #selector(handleQuantityTap))
        productQuantity.addGestureRecognizer(tapQuantity)
        let tapCheckBox = UITapGestureRecognizer(target: self, action: #selector(handleCheckBoxTap))
        checkBox.addGestureRecognizer(tapCheckBox)
        productImage.roundedAllSide(with: 8)
        btnPlus.roundedAllSide(with: 2)
        btnMinus.roundedAllSide(with: 2)
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        
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
        self.productImage.backgroundColor = UIColor(named: cartItem.colorCode ?? "#f3f3f3")
        if cartItem.isSelected {
            checkBox.setImage( UIImage(named: "ic_checked"), for: UIControl.State.normal)
        } else {
            checkBox.setImage( UIImage(named: "ic_unchecked"), for: UIControl.State.normal)
        }
        productName.text = cartItem.productName
        productQuantity.text = String(cartItem.productQuantity)
        productPrice.text = "\(cartItem.productPrice)$"

        if let imageName = cartItem.productImage {
            self.productImage.sd_setImage(with: URL(string: imageName), placeholderImage: UIImage(systemName: "circles.hexagonpath"), options: .continueInBackground, completed: nil)
        }
        
        if cartItem.productQuantity == 0 {
            checkBox.isEnabled = false
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
