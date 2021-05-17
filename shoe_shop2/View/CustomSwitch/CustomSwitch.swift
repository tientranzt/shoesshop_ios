//
//  CustomSwitch.swift
//
//
//  Created by Nhat on 5/6/21.
//

import UIKit

class CustomSwitch: UIControl {
    
    public var onTintColor = UIColor(red: 79/255, green: 100/255, blue: 283/255, alpha: 1)
    public var offTintColor = UIColor.black
    public var cornerRadius: CGFloat = 0.5
    public var thumbCornerRadius: CGFloat = 0.5
    public var thumbSize = CGSize.zero
    public var padding: CGFloat = 1
    
    
    public var isOn: Bool = true
    
    public var animationDuration: Double = 0.5
    
    fileprivate var thumbView = UIView(frame: CGRect.zero)
    fileprivate var crossbar = UIView(frame: CGRect.zero)
    
    fileprivate var onPoint = CGPoint.zero
    
    fileprivate var offPoint = CGPoint.zero
    
    fileprivate var isAnimating = false
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.setupUI()
    }
    
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if !self.isAnimating {
            //self.layer.cornerRadius = 8
            //self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
            self.crossbar.frame = CGRect(x: 0, y: self.bounds.height/3, width: self.bounds.width, height: self.bounds.height/3)
            self.crossbar.backgroundColor = UIColor.gray
            self.crossbar.layer.cornerRadius = self.bounds.height/6
            self.crossbar.isUserInteractionEnabled = true
            
            // thumb managment
            let thumbSize = self.thumbSize != CGSize.zero ? self.thumbSize : CGSize(width:self.bounds.size.height - 2, height: self.bounds.size.height - 2)
            let yPostition = (self.bounds.size.height - thumbSize.height) / 2
            
            self.onPoint = CGPoint(x: self.bounds.size.width - thumbSize.width - self.padding, y: yPostition)
            self.offPoint = CGPoint(x: self.padding, y: yPostition)
            
            self.thumbView.frame = CGRect(origin: self.isOn ? self.onPoint : self.offPoint, size: thumbSize)
            
            self.thumbView.layer.cornerRadius = thumbSize.height * self.thumbCornerRadius
            
        }
    }
    
    
    
    private func clear() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    func setupUI() {
        self.clear()
        //self.clipsToBounds = true
        
        let tapForThumView = UITapGestureRecognizer(target: self, action: #selector(self.animate))
        let tapForCrossBar = UITapGestureRecognizer(target: self, action: #selector(self.animate))
        self.thumbView.isUserInteractionEnabled = true
        
        self.thumbView.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
        self.thumbView.isUserInteractionEnabled = false
        self.thumbView.layer.shadowColor = UIColor.black.cgColor
        self.thumbView.layer.shadowRadius = 1.5
        self.thumbView.layer.shadowOpacity = 0.4
        self.thumbView.layer.shadowOffset = CGSize(width: 0.75, height: 2)
        self.thumbView.isUserInteractionEnabled = true
        self.thumbView.addGestureRecognizer(tapForThumView)
        
        
        self.crossbar.frame = CGRect(x: 0, y: self.bounds.height/3, width: self.bounds.width, height: self.bounds.height/3)
        self.crossbar.backgroundColor = UIColor.gray
        self.crossbar.layer.cornerRadius = self.bounds.height/6
        self.crossbar.isUserInteractionEnabled = true
        self.crossbar.addGestureRecognizer(tapForCrossBar)
        
        self.addSubview(crossbar)
        self.addSubview(self.thumbView)
    }
    
    @objc private func animate() {
        self.isOn = !self.isOn
        self.isAnimating = true
        UIView.animate(withDuration: self.animationDuration, delay: 0, usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.5, options: [UIView.AnimationOptions.curveEaseOut,UIView.AnimationOptions.beginFromCurrentState], animations:{self.thumbView.frame.origin.x = self.isOn ? self.onPoint.x : self.offPoint.x; self.thumbView.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
                       }, completion: { _ in
                        self.isAnimating = false
                        self.sendActions(for: UIControl.Event.valueChanged)
                       })
        
    }
    
    
}
