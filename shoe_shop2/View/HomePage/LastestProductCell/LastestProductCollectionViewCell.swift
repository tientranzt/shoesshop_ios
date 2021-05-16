import UIKit
import SDWebImage
class LastestProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lastestProductImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        containerView.roundedAllSide(with: 8)
    }
    
    func customInitCell(product : ProductModel)  {
        containerView.backgroundColor = UIColor(named: product.colorCode)
        let loadingImage  = UIImage(systemName: "circles.hexagonpath")
        lastestProductImage.tintColor = UIColor(named: ColorTheme.subGrayBackground)!
        lastestProductImage.sd_setImage(with: URL(string: product.image)!, placeholderImage: loadingImage, options: .continueInBackground, completed: nil)
    }

}
