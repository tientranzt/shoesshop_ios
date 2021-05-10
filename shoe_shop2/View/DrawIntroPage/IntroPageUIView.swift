//
//  IntroPageUIView.swift
//  shoe_shop2
//
//  Created by Nguyen Thanh Phuc on 5/8/21.
//

import UIKit


class IntroPageUIView: UIView {

   
    override func draw(_ rect: CGRect) {
        // Drawing code
        DrawIntroPage.drawCanvas1(frame: self.bounds, resizing: .center)
        
    }

}
