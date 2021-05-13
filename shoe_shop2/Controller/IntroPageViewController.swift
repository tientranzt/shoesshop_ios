//
//  IntroPageViewController.swift
//  shoe_shop2
//
//  Created by Nguyen Thanh Phuc on 5/8/21.
//

import UIKit
import FSPagerView


class IntroPageViewController: UIViewController {
    
    
    var indexViewDisplay: Int = 0
    @IBOutlet weak var sloganLabel: UILabel!
    @IBOutlet weak var goToViewButton: UIButton!
    fileprivate let imageNames = ["introImage.png","introImage.png","introImage.png"]
    
    fileprivate let transformerNames = ["cross fading", "zoom out", "depth", "linear", "overlap", "ferris wheel", "inverted ferris wheel", "coverflow", "cubic"]
    fileprivate let transformerTypes: [FSPagerViewTransformerType] = [.crossFading, .zoomOut, .depth, .linear, .overlap, .ferrisWheel, .invertedFerrisWheel, .coverFlow, .cubic]
    fileprivate var typeIndex = 0 {
        didSet {
            let type = self.transformerTypes[typeIndex]
            self.pagerView.transformer = FSPagerViewTransformer(type:type)
            switch type {
            case .crossFading, .zoomOut, .depth:
                self.pagerView.itemSize = FSPagerView.automaticSize
                self.pagerView.decelerationDistance = 1
            case .linear, .overlap:
                let transform = CGAffineTransform(scaleX: 0.6, y: 0.75)
                self.pagerView.itemSize = self.pagerView.frame.size.applying(transform)
                self.pagerView.decelerationDistance = FSPagerView.automaticDistance
            case .ferrisWheel, .invertedFerrisWheel:
                self.pagerView.itemSize = CGSize(width: 180, height: 140)
                self.pagerView.decelerationDistance = FSPagerView.automaticDistance
            case .coverFlow:
                self.pagerView.itemSize = CGSize(width: 220, height: 170)
                self.pagerView.decelerationDistance = FSPagerView.automaticDistance
            case .cubic:
                let transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                self.pagerView.itemSize = self.pagerView.frame.size.applying(transform)
                self.pagerView.decelerationDistance = 1
            }
        }
    }
    
    //MARK: - Outlet PageView
    @IBOutlet weak var pagerView: FSPagerView!{
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.typeIndex = 1
            goToViewButton.isHidden = true

        }
    }
    
    @IBOutlet weak var pageControl: FSPageControl! {
        didSet {
            self.pageControl.numberOfPages = self.imageNames.count
            self.pageControl.setFillColor(UIColor(named: ColorTheme.middleGrayBackground), for: .normal)
            
            self.pageControl.setFillColor(UIColor(named: ColorTheme.backgroundButton), for: .selected)
            self.pageControl.contentHorizontalAlignment = .center
            //self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let index = self.typeIndex
        self.typeIndex = index // Manually trigger didSet
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        sloganLabel.text = "GO HAPPY GO ANYWHERE"
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        goToViewButton.layer.cornerRadius = goToViewButton.layer.frame.width / 2
        goToViewButton.clipsToBounds = true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var shouldAutorotate: Bool {
        return true
    }
    @IBAction func handleGoButton(_ sender: UIButton) {
        
        let tabController = CustomTabBarController()
        tabController.view.backgroundColor = .white
        tabController.modalPresentationStyle = .fullScreen
        
        present(tabController, animated: true, completion: nil)
    }
}

extension IntroPageViewController: FSPagerViewDataSource, FSPagerViewDelegate{
    
        
    
    //MARK: - PageView Data Source
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.imageNames.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell{
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.imageNames[index])
        cell.imageView?.contentMode = .scaleAspectFit
        cell.imageView?.clipsToBounds = true
        
        
        let drawView = IntroPageUIView.init()
        drawView.backgroundColor = .white
        
        cell.isUserInteractionEnabled = false
        cell.backgroundView = drawView
        
        return cell
    }
    
    // MARK:- FSPagerView Delegate
    
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int) {
//        print("willDisPlay : \(index)")
        indexViewDisplay = index
    }
    
    func pagerView(_ pagerView: FSPagerView, didEndDisplaying cell: FSPagerViewCell, forItemAt index: Int) {
//        print("didEndDisplaying : \(index)")
//        indexDidEndDisplaying = index
//        //updateUI(index: index)
        if index != indexViewDisplay {
            updateUI(index: indexViewDisplay)
        }
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pageControl.currentPage = pagerView.currentIndex
    }
    
    func updateUI (index: Int) {
        switch index {
        case 0:
            UIView.transition(with: sloganLabel,
                              duration: 0.5,
                           options: .transitionCrossDissolve,
                        animations: { [weak self] in
                            self?.sloganLabel.text = "GO HAPPY GO ANYWHERE"
                     }, completion: nil)
            goToViewButton.isHidden = true
            sloganLabel.isHidden = false
        case 1:
            UIView.transition(with: sloganLabel,
                              duration: 0.5,
                           options: .transitionCrossDissolve,
                        animations: { [weak self] in
                            self?.sloganLabel.text = "BRING POWER TO YOUR STEPS"
                     }, completion: nil)
            goToViewButton.isHidden = true
            sloganLabel.isHidden = false
        case 2:
            goToViewButton.isHidden = false
            sloganLabel.isHidden = true
        default:
            print("default")
        }
    }
}
