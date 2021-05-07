import UIKit
import FSPagerView



class DetailProductViewController: UIViewController {

    
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
    
    fileprivate let sectionTitles = ["Configurations", "Decelaration Distance", "Item Size", "Interitem Spacing", "Number Of Items"]
    fileprivate let configurationTitles = ["Automatic sliding","Infinite"]
    fileprivate let decelerationDistanceOptions = ["Automatic", "1", "2"]
    fileprivate let imageNames = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg"]
    fileprivate var numberOfItems = 7
    
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
            //self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customSizeButton()
        customColorButton()
        addToCardButton.roundedAllSide(with: 16)
        setVisibleSizeButton(show: sizeEightButton, hidden: sizeNineButton, hidden: sizeTenButton)
        setVisibleColorButton(buttonChoose: colorGreenShoeButton)
        //contentView.roundedAllSide(with: 50)
       
    }
    

    override func viewWillLayoutSubviews() {
        viewChoose.layer.masksToBounds = true
        viewChoose.layer.cornerRadius = viewChoose.frame.size.width / 2
    }
    //MARK: - Set Landscape or Portrait
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        if UIDevice.current.orientation.isLandscape {
//            print("Landscape")
//            contentView.roundCorners(corners: [.topLeft, .topRight], radius: 8.0)
//        } else {
//            print("Portrait")
//            contentView.roundCorners(corners: [.topLeft, .topRight], radius: 50.0)
//        }
//    }
    
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
        return self.numberOfItems
    }

    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell{
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.imageNames[index])
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        //cell.textLabel?.text = index.description+index.description
        return cell
    }

    // MARK:- FSPagerView Delegate

//    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
//        pagerView.deselectItem(at: index, animated: true)
//        pagerView.scrollToItem(at: index, animated: true)
//    }

    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
    }

    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pageControl.currentPage = pagerView.currentIndex
    }

//    @IBAction func sliderValueChanged(_ sender: UISlider) {
//        switch sender.tag {
//        case 1:
//            let newScale = 0.5+CGFloat(sender.value)*0.5 // [0.5 - 1.0]
//            self.pagerView.itemSize = self.pagerView.frame.size.applying(CGAffineTransform(scaleX: newScale, y: newScale))
//        case 2:
//            self.pagerView.interitemSpacing = CGFloat(sender.value) * 20 // [0 - 20]
//        case 3:
//            self.numberOfItems = Int(roundf(sender.value*7.0))
//            self.pageControl.numberOfPages = self.numberOfItems
//            self.pagerView.reloadData()
//        default:
//            break
//        }
//    }

}

