import UIKit

extension UIView {
    
    func roundedAllSide(with radius : CGFloat)  {
        layer.masksToBounds = true
        layer.cornerRadius = radius
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func shadow(width x : CGFloat, height y : CGFloat, with color : UIColor)  {
        layer.shadowColor = color.cgColor
        layer.shadowRadius = 1
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowOpacity = 1
        layer.masksToBounds = false
    }
    
}

