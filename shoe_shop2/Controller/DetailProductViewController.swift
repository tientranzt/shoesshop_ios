import UIKit
import FSPagerView



class DetailProductViewController: UIViewController {
    
    let viewChoose = UIView()
    var backgroundScrollView = UIColor()
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var parentPagerView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var reviewLabel: UILabel!
    
    //MARK: - Outlet button size
    @IBOutlet weak var sizeEightButton: UIButton!
    @IBOutlet weak var sizeNineButton: UIButton!
    @IBOutlet weak var sizeTenButton: UIButton!
    
    //MARK: - Outlet button color
    @IBOutlet weak var colorGreenShoeButton: UIButton!
    @IBOutlet weak var colorPurpleShoeButton: UIButton!
    @IBOutlet weak var colorPinkShoeButton: UIButton!
    
    //MARK: - Outlet button Add To Card
    @IBOutlet weak var addToCardButton: UIButton!
    
    fileprivate let imageNames = ["shoe2", "shoe2", "shoe2", "shoe2"]
    
    //MARK: - Outlet PageView
    @IBOutlet weak var pagerView: FSPagerView!{
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.pagerView.itemSize = FSPagerView.automaticSize
        }
    }
    
    @IBOutlet weak var pageControl: FSPageControl! {
        didSet {
            self.pageControl.numberOfPages = self.imageNames.count
            self.pageControl.contentHorizontalAlignment = .center
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundScrollView = colorGreenShoeButton.backgroundColor ?? .white
        customSizeButton()
        customColorButton()
        handleColorButton(parentView, parentPagerView, pagerView, colorGreenShoeButton)
        setVisibleSizeButton(show: sizeEightButton, hidden: sizeNineButton, hidden: sizeTenButton)
        setVisibleColorButton(buttonChoose: colorGreenShoeButton)
        addToCardButton.roundedAllSide(with: 8)
        contentView.roundedAllSide(with: 8)
        contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        reviewLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pressReview)))
        reviewLabel.underLine()
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    //MARK: - Tapgesture
    @objc func pressReview() {
        let reviewPageVC = UIStoryboard(name: "ReviewPage", bundle: nil).instantiateViewController(identifier: "ReviewViewController") as! ReviewViewController
        present(reviewPageVC, animated: true, completion: nil)
     
    }
    
    override func viewWillLayoutSubviews() {
        viewChoose.layer.masksToBounds = true
        viewChoose.layer.cornerRadius = viewChoose.frame.size.width / 2
    }
    
    func customSizeButton() {
        sizeEightButton.roundedAllSide(with: 8)
        sizeNineButton.roundedAllSide(with: 8)
        sizeTenButton.roundedAllSide(with: 8)
        
        sizeEightButton.layer.borderWidth = 0.5
        sizeNineButton.layer.borderWidth = 0.5
        sizeTenButton.layer.borderWidth = 0.5
        
    }
    
    private func customColorButton() {
        colorGreenShoeButton.layer.masksToBounds = true
        colorGreenShoeButton.layer.cornerRadius = colorGreenShoeButton.frame.size.width / 2
        
        colorPurpleShoeButton.layer.masksToBounds = true
        colorPurpleShoeButton.layer.cornerRadius = colorPurpleShoeButton.frame.size.width / 2
        
        colorPinkShoeButton.layer.masksToBounds = true
        colorPinkShoeButton.layer.cornerRadius = colorPinkShoeButton.frame.size.width / 2
        
    }
    
    //MARK: - Action Button Size
    @IBAction func pressSizeButton(_ sender: UIButton) {
        switch sender.tag {
        case 8:
            setVisibleSizeButton(show: sizeEightButton, hidden: sizeNineButton, hidden: sizeTenButton)
        case 9:
            setVisibleSizeButton(show: sizeNineButton, hidden: sizeEightButton, hidden: sizeTenButton)
        case 10:
            setVisibleSizeButton(show: sizeTenButton, hidden: sizeNineButton, hidden: sizeEightButton)
        default:
            print("default")
        }
    }
    
    @IBAction func pressPopToViewHomePage(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Enable True or False
    private func setVisibleSizeButton(show buttonEnableTrue:UIButton,hidden buttonEnabelFalseOne:UIButton,hidden buttonEnabelFalseTwo:UIButton) {
        
        buttonEnableTrue.backgroundColor = UIColor(named: ColorTheme.hightlightSizeBackground)
        buttonEnableTrue.setTitleColor(UIColor.white, for: .normal)
        buttonEnableTrue.layer.borderWidth = 0.5
        
        buttonEnabelFalseOne.backgroundColor = UIColor(named: ColorTheme.grayMainBackground)
        buttonEnabelFalseOne.tintColor = UIColor(named: ColorTheme.mainBlackBackground)
        buttonEnabelFalseOne.layer.borderWidth = 0
        
        buttonEnabelFalseTwo.backgroundColor = UIColor(named: ColorTheme.grayMainBackground)
        buttonEnabelFalseTwo.tintColor = UIColor(named: ColorTheme.mainBlackBackground)
        buttonEnabelFalseTwo.layer.borderWidth = 0
    }
    
    
    
    //MARK: - Xử lý button Color
    @IBAction func pressColorButton(_ sender: UIButton) {
//        switch sender.tag {
//        case 1:
//            self.view.backgroundColor = sender.backgroundColor
//            backgroundScrollView = sender.backgroundColor ?? .white
//            setVisibleColorButton(buttonChoose: colorGreenShoeButton)
//            handleColorButton(parentView, parentPagerView, pagerView, sender)
//        case 2:
//            self.view.backgroundColor = sender.backgroundColor
//            backgroundScrollView = sender.backgroundColor ?? .white
//            setVisibleColorButton(buttonChoose: colorPurpleShoeButton)
//            handleColorButton(parentView, parentPagerView, pagerView, sender)
//        case 3:
//            self.view.backgroundColor = sender.backgroundColor
//            backgroundScrollView = sender.backgroundColor ?? .white
//            setVisibleColorButton(buttonChoose: colorPinkShoeButton)
//            handleColorButton(parentView, parentPagerView, pagerView, sender)
//        default:
//            print("default")
//        }
        self.view.backgroundColor = sender.backgroundColor
        backgroundScrollView = sender.backgroundColor ?? .white
        setVisibleColorButton(buttonChoose: sender)
        handleColorButton(pagerView, parentPagerView, pagerView, sender)
    }
    
    //MARK: - Handle color button
    private func handleColorButton(_ view1: UIView,_ view2: UIView,_ view3: UIView,_ senderButton:UIButton) {
        view1.backgroundColor = senderButton.backgroundColor
        view2.backgroundColor = senderButton.backgroundColor
        view3.backgroundColor = senderButton.backgroundColor
    }
    
    //MARK: - Enable True or False
    private func setVisibleColorButton(buttonChoose:UIButton) {
        
        viewChoose.translatesAutoresizingMaskIntoConstraints = false
        viewChoose.backgroundColor = .white
        
        buttonChoose.addSubview(viewChoose)
        NSLayoutConstraint.activate([
            viewChoose.centerYAnchor.constraint(equalTo: buttonChoose.centerYAnchor, constant: 0),
            viewChoose.centerXAnchor.constraint(equalTo: buttonChoose.centerXAnchor, constant: 0),
            viewChoose.widthAnchor.constraint(equalToConstant: 6),
            viewChoose.heightAnchor.constraint(equalToConstant: 6)
        ])
    }
}

extension DetailProductViewController: FSPagerViewDataSource, FSPagerViewDelegate{
    
    //MARK: - PageView Data Source
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.imageNames.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell{
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: imageNames[index])
        //cell.imageView?.downloaded(from: imageNames[index])
        cell.imageView?.contentMode = .scaleAspectFit
        cell.imageView?.clipsToBounds = true
        cell.isUserInteractionEnabled = false
        return cell
    }
    
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pageControl.currentPage = pagerView.currentIndex
    }
}

extension DetailProductViewController : UIScrollViewDelegate{
   
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0{
            self.view.backgroundColor = backgroundScrollView
        }else{
            self.view.backgroundColor = .white
        }
    }
}
