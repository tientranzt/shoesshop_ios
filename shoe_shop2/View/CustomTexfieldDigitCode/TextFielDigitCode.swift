//
//  TexfielDigitCodeUIView.swift
//  shoe_shop2
//
//  Created by Nhat on 5/13/21.
//

import UIKit

class TextFielDigit: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var textField: UITextField!
    let border: CALayer = CALayer()
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        // set up view
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addBottomBorderWithColor(color: UIColor.gray, width: 2)
    }
    
    private func setUpView() {
        
        let viewFromXib =  Bundle.main.loadNibNamed("TextFielDigitCode", owner: self, options: nil)?[0] as! UIView
        viewFromXib.frame = self.bounds
        self.textField.textAlignment = .center
        self.textField.borderStyle = .none
        self.textField.font = self.textField.font?.withSize(18)
        //self.textField.sizeToFit()
        self.addSubview(viewFromXib)
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        border.removeFromSuperlayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.contentView.layer.addSublayer(border)
      }

}
