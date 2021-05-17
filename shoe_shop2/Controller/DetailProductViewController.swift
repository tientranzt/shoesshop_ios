import UIKit
import FSPagerView



class DetailProductViewController: UIViewController {
    
    
    //MARK:- TRIEULX
    var indexColorSelected: Int = 0
    var indexSizeSelected: Int = -1
    var currentTitle: String = ""
    
    
    let viewChoose = UIView()
    var backgroundScrollView = UIColor()
    
    var product : ProductModel?
    var productColorArray: [ProductColor] = []
    var buttonSizeDictionary: [String: Int] = [:]
    var productImageArray: [String] = []
    var indexViewDisplay: Int = 0
    var sizeDictionaryArray : [String: [String: Int]] = [:]
    var numberOfShoesSize: [Int] = []
    
    @IBOutlet weak var nameShoesLabel: UILabel!
    @IBOutlet weak var priceShoesLabel: UILabel!
    @IBOutlet weak var descriptionShoesLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var parentPagerView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    
    //MARK: - Outlet button size
    @IBOutlet weak var sizeFirstButton: UIButton!
    @IBOutlet weak var sizeSecondButton: UIButton!
    @IBOutlet weak var sizeThirdButton: UIButton!
    @IBOutlet weak var sizeFourthButton: UIButton!
    var sizeButtonArray: [UIButton] = []
    
    //MARK: - Outlet button color
    @IBOutlet weak var colorFirstShoeButton: UIButton!
    @IBOutlet weak var colorSecondShoeButton: UIButton!
    @IBOutlet weak var colorThirdShoeButton: UIButton!
    var colorButtonArray: [UIButton] = []
    
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
                    self.productImageArray.append(item.imageLink)
                    self.sizeDictionaryArray.updateValue(self.buttonSizeDictionary, forKey: item.colorCode)
                    
                }
                DispatchQueue.main.async {
                    self.pagerView.reloadData()
                    self.handleData(index: 0)
                    self.showColorButton()
                    self.handleColorViews(self.colorFirstShoeButton)
                    self.view.backgroundColor = self.colorFirstShoeButton.backgroundColor
                    self.backgroundScrollView = self.colorFirstShoeButton.backgroundColor ?? .white
                    self.handleSizeButton(indexButton: 0)
                }
            }
        }
    }
    
    func handleData(index: Int) {
        //MARK:- TRIEULX
        indexColorSelected = index
        
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
    
    func handleSizeButton(indexButton: Int) {
        //MARK: - Lấy size giày trên Firebase gán vào button
        print(sizeDictionaryArray)
        for (index, item) in sizeDictionaryArray.values.enumerated(){
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
        
        //MARK: - Nếu số lượng giày của size đó hết button đó sẽ bị ẩn đi
        for (index, value) in numberOfShoesSize.enumerated(){
            if value == 0{
                sizeButtonArray[index].isHidden = true
            }else{
                sizeButtonArray[index].isHidden = false
            }
        }
        //MARK: - Xoá button đang được sellect khi đổi màu
        for buttonSize in sizeButtonArray{
            buttonSize.backgroundColor = UIColor(named: ColorTheme.grayMainBackground)
            buttonSize.tintColor = UIColor(named: ColorTheme.mainBlackBackground)
            buttonSize.layer.borderWidth = 0
        }
        setClearSelectButton(arrayButton: sizeButtonArray)
    }
    
    
    //MARK: - Action Button Size
    @IBAction func pressSizeButton(_ sender: UIButton) {
        indexSizeSelected = sender.tag
        
        handleSelectButtonSize(sender: sender.tag, arrayButton: sizeButtonArray)
        print("Số lượng tồn: \(numberOfShoesSize[sender.tag])")
        guard let title = sender.currentTitle else {
            return
        }
        currentTitle = title
    }
    
    @IBAction func pressPopToViewHomePage(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Enable True or False
    private func setClearSelectButton(arrayButton: [UIButton]) {
        for itemButton in sizeButtonArray{
            itemButton.backgroundColor = UIColor(named: ColorTheme.grayMainBackground)
            itemButton.setTitleColor( UIColor(named: ColorTheme.mainBlackBackground), for: .normal)
            itemButton.layer.borderWidth = 0
        }
    }
    
    private func handleSelectButtonSize(sender: Int, arrayButton: [UIButton]) {
        for (index, itemButton) in sizeButtonArray.enumerated(){
            if itemButton.tag == sender{
                sizeButtonArray[index].backgroundColor = UIColor(named: ColorTheme.hightlightSizeBackground)
                sizeButtonArray[index].setTitleColor(UIColor.white, for: .normal)
                sizeButtonArray[index].layer.borderWidth = 0.5
            }else if itemButton.tag != sender{
                itemButton.backgroundColor = UIColor(named: ColorTheme.grayMainBackground)
                itemButton.setTitleColor( UIColor(named: ColorTheme.mainBlackBackground), for: .normal)
                itemButton.layer.borderWidth = 0
            }
        }
    }
    
    //MARK: - Action Button Color
    @IBAction func pressColorButton(_ sender: UIButton) {
        self.view.backgroundColor = sender.backgroundColor
        backgroundScrollView = sender.backgroundColor ?? .white
        sellectedButtonColor(buttonChoose: sender)
        handleColorViews(sender)
        pagerView.scrollToItem(at: sender.tag, animated: true)
        handleData(index: sender.tag)
        handleSizeButton(indexButton: sender.tag)
    }
    
    //MARK: - Handle Button Color
    private func showColorButton() {
        for (index,keys) in sizeDictionaryArray.keys.enumerated() {
            self.colorButtonArray[index].backgroundColor = UIColor(named: keys)
            self.colorButtonArray[index].isHidden = false
        }
    }
    private func roundedColorButton() {
        for item in colorButtonArray {
            item.layer.masksToBounds = true
            item.layer.cornerRadius = colorFirstShoeButton.frame.size.width / 2
            item.isHidden = true
        }
    }
    
    //MARK: - Handle background color of Views
    private func handleColorViews(_ senderButton:UIButton) {
        pagerView.backgroundColor = senderButton.backgroundColor
        parentPagerView.backgroundColor = senderButton.backgroundColor
        pagerView.backgroundColor = senderButton.backgroundColor
    }
    
    
    //MARK: - Add a view when press button Color
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
            handleColorViews(self.colorFirstShoeButton)
            self.view.backgroundColor = colorFirstShoeButton.backgroundColor
            backgroundScrollView = colorFirstShoeButton.backgroundColor ?? .white
        }else if index == 1{
            sellectedButtonColor(buttonChoose: colorSecondShoeButton)
            handleColorViews(self.colorSecondShoeButton)
            self.view.backgroundColor = colorSecondShoeButton.backgroundColor
            backgroundScrollView = colorSecondShoeButton.backgroundColor ?? .white
        }else if index == 2 {
            sellectedButtonColor(buttonChoose: colorThirdShoeButton)
            handleColorViews(self.colorThirdShoeButton)
            self.view.backgroundColor = colorThirdShoeButton.backgroundColor
            backgroundScrollView = colorThirdShoeButton.backgroundColor ?? .white
        }
    }
    @IBAction func pressAddToCart(_ sender: Any) {
//        if indexSizeSelected == -1 {
//            return
//        }
//
//        let now = Date()
//        let formatter = DateFormatter()
//        formatter.dateStyle = .short
//        formatter.timeStyle = .short
//        let cart = CartModel(username: "lxt", // đợi login gửi qua
//                             shoeName: product!.productName,
//                             shoeId: product!.id,
//                             shoeColorId: productColorArray[indexColorSelected].id,
//                             shoeSizeId: sizeButtonArray[indexSizeSelected].currentTitle!, // Chưa hiểu cách bắt sự kiện :v
//                             shoeQuantity: 1,
//                             shoePrice: Int(productColorArray[indexColorSelected].price) ?? -1,
//                             shoeImage: productColorArray[indexColorSelected].imageLink,
//                             createdAt: formatter.string(from: now)
//        )
//        if CoreDataManager.share.insertCart(cartModel: cart) {
//            showAlertNotify(title: "Insert item", message: "[\(product!.productName)] insert into your cart success!")
//        } else {
//            showAlertNotify(title: "Insert item", message: "[\(product!.productName)] exists in your cart")
//        }
    }
}


extension DetailProductViewController: FSPagerViewDataSource, FSPagerViewDelegate{
    
    //MARK: - PageView Data Source
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return productImageArray.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell{
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        self.pageControl.numberOfPages = productImageArray.count
        
        cell.imageView?.contentMode = .scaleAspectFit
        cell.imageView?.clipsToBounds = true
        cell.isUserInteractionEnabled = false
        cell.imageView?.downloaded(from: productImageArray[index])
        
        handleData(index: index)
        handleSizeButton(indexButton: index)
        
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
