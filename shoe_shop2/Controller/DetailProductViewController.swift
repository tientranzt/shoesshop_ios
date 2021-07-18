//
//  DetailProductViewController.swift
//  shoe_shop2
//
//  Created by Nguyen Thanh Phuc on 5/5/21.
//
import UIKit
import FSPagerView



class DetailProductViewController: UIViewController {
    
    let viewChoose = UIView()
    var backgroundScrollView = UIColor()
    var colorButtonArray: [UIButton] = []
    var sizeButtonArray: [UIButton] = []
    var product : ProductModel?
    var productColorArray: [ProductColor] = []
    var buttonSizeDictionary: [String: Int] = [:]
    var shoesImageArray: [String] = []
    var indexViewDisplay: Int = 0
    var dictionArray : [String: [String: Int]] = [:]
    var numberOfShoesSize: [Int] = []
    
    @IBOutlet weak var nameShoesLabel: UILabel!
    @IBOutlet weak var priceShoesLabel: UILabel!
    @IBOutlet weak var descriptionShoesLabel: UILabel!
    
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var parentPagerView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var reviewLabel: UILabel!
    
    //MARK: - Outlet button size
    @IBOutlet weak var sizeFirstButton: UIButton!
    @IBOutlet weak var sizeSecondButton: UIButton!
    @IBOutlet weak var sizeThirdButton: UIButton!
    @IBOutlet weak var sizeFourthButton: UIButton!
    
    //MARK: - Outlet button color
    @IBOutlet weak var colorFirstShoeButton: UIButton!
    @IBOutlet weak var colorSecondShoeButton: UIButton!
    @IBOutlet weak var colorThirdShoeButton: UIButton!
    
    //MARK: - Outlet button Add To Card
    @IBOutlet weak var addToCardButton: UIButton!
    
    //MARK: - Outlet PageView
    @IBOutlet weak var pagerView: FSPagerView!{
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.pagerView.itemSize = FSPagerView.automaticSize
        }
    }
    
    @IBOutlet weak var pageControl: FSPageControl! {
        didSet {
            self.pageControl.contentHorizontalAlignment = .center
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorButtonArray = [colorFirstShoeButton,colorSecondShoeButton,colorThirdShoeButton]
        sizeButtonArray = [sizeFirstButton, sizeSecondButton, sizeThirdButton, sizeFourthButton]
        self.backgroundScrollView = colorFirstShoeButton.backgroundColor ?? .white
        customSizeButton()
        roundedColorButton()
        getProductByColor()
        sellectedButtonColor(buttonChoose: colorFirstShoeButton)
        addToCardButton.roundedAllSide(with: 8)
        contentView.roundedAllSide(with: 8)
        contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        reviewLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pressReview)))
        reviewLabel.underLine()
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    //MARK: - Get Data Firebase
    func getProductByColor() {
        guard let idProduct = product?.id else {
            return
        }
        FirebaseManager.shared.fectProductColor(idPath: idProduct) { (data) in
            if let dataProductDetail = data.value as? [String: AnyObject] {
                dataProductDetail.forEach { (key : String, value: AnyObject) in
                    let detailProductColor =   FirebaseManager.shared.parseProductColorModel(idProductCategory: idProduct, id : key, object: value)
                    self.productColorArray.append(detailProductColor)
                }
                
                for item in self.productColorArray{
                    self.buttonSizeDictionary = item.size
                    self.shoesImageArray.append(item.imageLink)
                    self.dictionArray.updateValue(self.buttonSizeDictionary, forKey: item.colorCode)
                    
                }
                DispatchQueue.main.async {
                    self.pagerView.reloadData()
                    self.handleData(index: 0)
                    self.showColorButton()
                    self.handleColorButton(self.colorFirstShoeButton)
                    self.view.backgroundColor = self.colorFirstShoeButton.backgroundColor
                    self.backgroundScrollView = self.colorFirstShoeButton.backgroundColor ?? .white
                    self.checkButtonSize(indexButton: 0)
                }
            }
        }
    }
    
    func handleData(index: Int) {
        nameShoesLabel.text = product?.productName
        descriptionShoesLabel.text = productColorArray[index].description
        priceShoesLabel.text = "\(productColorArray[index].price)$"
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
    
    private func customSizeButton() {
        for item in sizeButtonArray {
            item.roundedAllSide(with: 8)
            item.layer.borderWidth = 0.5
        }
    }
    
    
    func checkButtonSize(indexButton: Int) {
        for (index, item) in dictionArray.values.enumerated(){
            if index == indexButton{
                let sortedKeys = Array(item.keys).sorted(by: <)
                //print("sortedKeys: \(sortedKeys)")
                for (index, keys) in sortedKeys.enumerated() {
                    sizeButtonArray[index].setTitle(keys, for: .normal)
                    guard let numberShoes = item[keys] else {
                        return
                    }
                    if numberOfShoesSize.count < 4 {
                        numberOfShoesSize.append(numberShoes)
                    }else{
                        numberOfShoesSize = []
                        numberOfShoesSize.append(numberShoes)
                    }
                }
            }
        }
        for (index, value) in numberOfShoesSize.enumerated(){
            if value == 0{
                sizeButtonArray[index].isHidden = true
            }else{
                sizeButtonArray[index].isHidden = false
            }
        }
    }
    
    
    //MARK: - Action Button Size
    @IBAction func pressSizeButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            setVisibleSizeButton(show: sizeFirstButton, hidden: sizeSecondButton, hidden: sizeThirdButton, hidden: sizeFourthButton)
            print("Số lượng tồn: \(numberOfShoesSize[0])")

        case 1:
            setVisibleSizeButton(show: sizeSecondButton, hidden: sizeFirstButton, hidden: sizeThirdButton, hidden: sizeFourthButton)
            print("Số lượng tồn: \(numberOfShoesSize[1])")
        case 2:
            setVisibleSizeButton(show: sizeThirdButton, hidden: sizeSecondButton, hidden: sizeFirstButton, hidden: sizeFourthButton)
            print("Số lượng tồn: \(numberOfShoesSize[2])")
        case 3:
            setVisibleSizeButton(show: sizeFourthButton, hidden: sizeSecondButton, hidden: sizeFirstButton, hidden: sizeThirdButton)
            print("Số lượng tồn: \(numberOfShoesSize[3])")
        default:
            print("default")
        }
       
    }
    
    @IBAction func pressPopToViewHomePage(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Enable True or False
    private func setVisibleSizeButton(show buttonEnableTrue:UIButton,hidden buttonEnabelFalseFirst:UIButton,hidden buttonEnabelFalseSecond:UIButton,hidden buttonEnabelFalseThirst:UIButton) {
        
        buttonEnableTrue.backgroundColor = UIColor(named: ColorTheme.hightlightSizeBackground)
        buttonEnableTrue.setTitleColor(UIColor.white, for: .normal)
        buttonEnableTrue.layer.borderWidth = 0.5
        
        buttonEnabelFalseFirst.backgroundColor = UIColor(named: ColorTheme.grayMainBackground)
        buttonEnabelFalseFirst.tintColor = UIColor(named: ColorTheme.mainBlackBackground)
        buttonEnabelFalseFirst.layer.borderWidth = 0
        
        buttonEnabelFalseSecond.backgroundColor = UIColor(named: ColorTheme.grayMainBackground)
        buttonEnabelFalseSecond.tintColor = UIColor(named: ColorTheme.mainBlackBackground)
        buttonEnabelFalseSecond.layer.borderWidth = 0
        
        buttonEnabelFalseThirst.backgroundColor = UIColor(named: ColorTheme.grayMainBackground)
        buttonEnabelFalseThirst.tintColor = UIColor(named: ColorTheme.mainBlackBackground)
        buttonEnabelFalseThirst.layer.borderWidth = 0
    }
    
    private func roundedColorButton() {
        for item in colorButtonArray {
            item.layer.masksToBounds = true
            item.layer.cornerRadius = colorFirstShoeButton.frame.size.width / 2
            item.isHidden = true
        }
    }
    
    //MARK: - Handle Button Color
    @IBAction func pressColorButton(_ sender: UIButton) {
        self.view.backgroundColor = sender.backgroundColor
        backgroundScrollView = sender.backgroundColor ?? .white
        sellectedButtonColor(buttonChoose: sender)
        handleColorButton(sender)
        pagerView.scrollToItem(at: sender.tag, animated: true)
        handleData(index: sender.tag)
        checkButtonSize(indexButton: sender.tag)
    }
    
    private func showColorButton() {
        for (index,keys) in dictionArray.keys.enumerated() {
            self.colorButtonArray[index].backgroundColor = UIColor(named: keys)
            self.colorButtonArray[index].isHidden = false
        }
    }
    
    //MARK: - Handle view backgroundColor
    private func handleColorButton(_ senderButton:UIButton) {
        pagerView.backgroundColor = senderButton.backgroundColor
        parentPagerView.backgroundColor = senderButton.backgroundColor
        pagerView.backgroundColor = senderButton.backgroundColor
    }
    
    //MARK: - Add view when press button Color
    private func sellectedButtonColor(buttonChoose:UIButton) {
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
    func handlerPagerView(index: Int) {
        if index == 0 {
            sellectedButtonColor(buttonChoose: colorFirstShoeButton)
            handleColorButton(self.colorFirstShoeButton)
            self.view.backgroundColor = colorFirstShoeButton.backgroundColor
            backgroundScrollView = colorFirstShoeButton.backgroundColor ?? .white
        }else if index == 1{
            sellectedButtonColor(buttonChoose: colorSecondShoeButton)
            handleColorButton(self.colorSecondShoeButton)
            self.view.backgroundColor = colorSecondShoeButton.backgroundColor
            backgroundScrollView = colorSecondShoeButton.backgroundColor ?? .white
        }else if index == 2 {
            sellectedButtonColor(buttonChoose: colorThirdShoeButton)
            handleColorButton(self.colorThirdShoeButton)
            self.view.backgroundColor = colorThirdShoeButton.backgroundColor
            backgroundScrollView = colorThirdShoeButton.backgroundColor ?? .white
        }
    }
}




extension DetailProductViewController: FSPagerViewDataSource, FSPagerViewDelegate{
    
    //MARK: - PageView Data Source
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return shoesImageArray.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell{
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        self.pageControl.numberOfPages = shoesImageArray.count
        
        cell.imageView?.contentMode = .scaleAspectFit
        cell.imageView?.clipsToBounds = true
        cell.isUserInteractionEnabled = false
        cell.imageView?.downloaded(from: shoesImageArray[index])
        handleData(index: index)
        checkButtonSize(indexButton: index)
        return cell
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pageControl.currentPage = pagerView.currentIndex
    }
    
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int) {
        indexViewDisplay = index
    }
    func pagerView(_ pagerView: FSPagerView, didEndDisplaying cell: FSPagerViewCell, forItemAt index: Int) {
        if indexViewDisplay != index {
            handlerPagerView(index: indexViewDisplay)
        }
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
