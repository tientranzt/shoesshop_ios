import UIKit
import FSPagerView



class DetailProductViewController: UIViewController {
    
    
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
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
    let viewChoose = UIView()
    
    var navBarDefaultColor: UIColor?
    var navBarDefaultShadowImage: UIImage?
    
    fileprivate let imageNames = ["shoe2", "shoe2"]
    
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
        customSizeButton()
        customColorButton()
        setVisibleSizeButton(show: sizeEightButton, hidden: sizeNineButton, hidden: sizeTenButton)
        setVisibleColorButton(buttonChoose: colorGreenShoeButton)
        addToCardButton.roundedAllSide(with: 8)
        contentView.roundedAllSide(with: 8)
        contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        reviewLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pressReview)))
        reviewLabel.underLine()
        navigationController?.navigationBar.tintColor = UIColor(named: ColorTheme.mainBlackBackground)
    }
    
    //MARK: - Tapgesture
    @objc func pressReview() {
        let reviewPageVC = UIStoryboard(name: "ReviewPage", bundle: nil).instantiateViewController(identifier: "ReviewViewController") as! ReviewViewController
        present(reviewPageVC, animated: true, completion: nil)
     
    }
    
    //MARK: - handle NavigationBar will apprear
    override func viewWillAppear(_ animated: Bool) {
        navBarDefaultColor = self.navigationController?.navigationBar.barTintColor
        navBarDefaultShadowImage = self.navigationController?.navigationBar.shadowImage
        
        self.navigationController?.navigationBar.barTintColor = UIColor(named: ColorTheme.shoeBackground4)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    //MARK: - handle NavigationBar will didappear
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = navBarDefaultColor
        self.navigationController?.navigationBar.shadowImage = navBarDefaultShadowImage
        self.navigationController?.navigationBar.isTranslucent = true
        
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
    
    
    //MARK: - Enable True or False
    private func setVisibleSizeButton(show buttonEnableTrue:UIButton,hidden buttonEnabelFalseOne:UIButton,hidden buttonEnabelFalseTwo:UIButton) {
        
        buttonEnableTrue.backgroundColor = UIColor(named: ColorTheme.hightlightSizeBackground)
        buttonEnableTrue.setTitleColor(UIColor.white, for: .normal)
        buttonEnableTrue.layer.borderWidth = 0
        
        buttonEnabelFalseOne.backgroundColor = UIColor(named: ColorTheme.grayMainBackground)
        buttonEnabelFalseOne.tintColor = UIColor(named: ColorTheme.mainBlackBackground)
        buttonEnabelFalseOne.layer.borderWidth = 0.5
        
        buttonEnabelFalseTwo.backgroundColor = UIColor(named: ColorTheme.grayMainBackground)
        buttonEnabelFalseTwo.tintColor = UIColor(named: ColorTheme.mainBlackBackground)
        buttonEnabelFalseTwo.layer.borderWidth = 0.5
    }
    
    
    
    //MARK: - Xử lý button Color
    @IBAction func pressColorButton(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            setVisibleColorButton(buttonChoose: colorGreenShoeButton)
        case 2:
            setVisibleColorButton(buttonChoose: colorPurpleShoeButton)
        case 3:
            setVisibleColorButton(buttonChoose: colorPinkShoeButton)
        default:
            print("default")
        }
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
    // 21:55
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
            self.view.backgroundColor = UIColor(named: ColorTheme.shoeBackground4)
        }else{
            self.view.backgroundColor = .white
        }
    }
}
