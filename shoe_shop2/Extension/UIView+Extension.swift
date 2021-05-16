import UIKit

extension UIView {
    
    func borderAllSide(width: CGFloat , color: CGColor) {
        layer.borderWidth = width
        layer.borderColor = color
    }
    
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
    
//    // fuction add border for bottom
//    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
//        let border = CALayer()
//        border.backgroundColor = color.cgColor
//        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
//        self.layer.addSublayer(border)
//      }
}

