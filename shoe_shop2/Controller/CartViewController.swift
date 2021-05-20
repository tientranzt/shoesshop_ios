import UIKit

class CartViewController: UIViewController {
    //MARK: - Outlet + properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var lblTotalItem: UILabel!
    @IBOutlet weak var btnCheckOut: UIButton!
    var totalItem: Int = 0 {
        didSet {
            lblTotalItem.text = "\(totalItem) item"
        }
    }
    var totalPrice: Int = 0 {
        didSet {
            lblTotalPrice.text = "\(totalPrice)$"
        }
    }
    var cartList: [Cart] = [Cart]()
    var itemNotExists: [String] = []
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        btnCheckOut.roundedAllSide(with: 8)
        configureTableView()
        btnCheckOut.addTarget(self, action: #selector(checkOutAction), for: .touchUpInside)
    }
    
    
    //MARK:- HANDLE ACTION CHECKOUT
    @objc func checkOutAction(_ sender: UIButton) {
        let list = cartList.filter({ $0.isSelected })
        if list.count == 0 {
            showAlertError(title: "My cart", message: "Your cart no item selected")
            return
        }
        
        let checkoutVC = UIStoryboard(name: "Checkout", bundle: nil).instantiateViewController(identifier: "checkoutPage") as! CheckoutViewController
        checkoutVC.cartListInput = list
        checkoutVC.dataInput = [
            "totalPrice" : totalPrice,
            "totalItem" : totalItem
        ]
        navigationController?.pushViewController(checkoutVC, animated: true)
    }
    
    
    func configureTableView() {
        tableView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: CartTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = 150
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
    }
    
    func fetchData()  {
        
        DispatchQueue.global().sync {
            self.cartList.removeAll()
            self.cartList = CoreDataManager.share.fetchAllItemCart()
            self.totalItem = CoreDataManager.share.getCountItemCartSelected()
            self.totalPrice = CoreDataManager.share.getTotalPriceItemCartSelected()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

//MARK: - HANDLE TABLEVIEW DELEGATE + DATASOURCE
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as! CartTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        //        set the delegate to self
        cell.cellDelegate = self
        //        set data for cell
        cell.setData(cartItem: cartList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        handleCheckBox(cell: self.tableView.cellForRow(at: indexPath) as! CartTableViewCell) // ~ click checkbox
    }
    
    //MARK:- Configure + Handle swipe delete item
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title:  "", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            // Call edit action
            self.showAlertDeleteItem(cell: self.tableView.cellForRow(at: indexPath) as! CartTableViewCell)
            // Reset state
            success(true)
        })
        let iconImage = UIImage(systemName: "trash")
        deleteAction.image = iconImage!.withTintColor(UIColor(named: "deleteButtonTint")!, renderingMode: .alwaysOriginal)
        deleteAction.backgroundColor = UIColor(named: "grayMainBackground")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

//MARK:- HANDLE CART CELL
extension CartViewController: CartTableViewCellDelegate {
    // protocol handle button plus
    func pressButtonPlus(cell: CartTableViewCell, didTapped button: UIButton?) {
        guard let text = cell.productQuantity.text else { return }
        if let quantity = Int(text) {
            setQuantity(cell: cell, quantity: quantity + 1)
        }
    }
    // protocol handle button minus
    func pressButtonMinus(cell: CartTableViewCell, didTapped button: UIButton?) {
        guard let text = cell.productQuantity.text else { return }
        if let quantity = Int(text) {
            setQuantity(cell: cell, quantity: quantity - 1)
        }
    }
    // protocol handle label quantity
    func pressLabelQuantity(cell: CartTableViewCell) {
        showAlertInputQuantity(cell: cell)
    }
    // protocol handle checkbox
    func pressCheckBox(cell: CartTableViewCell) {
        handleCheckBox(cell: cell)
    }
    
    //MARK: - Delete cart item via Alert confirm
    func showAlertDeleteItem(cell: CartTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else  { return }
        let cart = cartList[indexPath.row]
        
        let alert = UIAlertController(title: "Delete item", message: "[\(String(describing: cell.productName.text!))] \n Are you sure you want to delete this item ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in
            //update data
            guard let colorId = cart.productColorId else { return }
            if !CoreDataManager.share.deleteCart(colorId: colorId) {
                return
            }
            self.fetchData()
            print("Delete success")
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Handle event checkbox
    func handleCheckBox(cell: CartTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else  { return }
        let cart = cartList[indexPath.row]
        guard let productColorId = cart.productColorId else {
            return
        }
        //
        let isSelected = cart.isSelected
        if !CoreDataManager.share.updateCart(colorId: productColorId, isChecked: !isSelected) {
            showAlertError(title: "Error", message:  "Please try again.")
            return
        }
        totalItem = !isSelected ? totalItem + 1 : totalItem - 1
        totalPrice = !isSelected ? totalPrice + Int(cart.productPrice * cart.productQuantity) : totalPrice - Int(cart.productPrice * cart.productQuantity)
        cell.checkBox.isChecked = !isSelected //Set UI
        cart.isSelected = !isSelected //Require put last
    }
    
    //MARK: - Change quantity cart item
    func showAlertInputQuantity(cell: CartTableViewCell) {
        let alert = UIAlertController(title: "Input quantity", message: "[\(String(describing: cell.productName.text!))]", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.keyboardType = .numberPad
            textField.placeholder = cell.productQuantity.text
            textField.delegate = self // handle input
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            guard let text = alert.textFields?.first?.text else {
                self.showAlertError(title: "Input error", message:  "Invalid quantity.")
                return
            }
            if let quantity = Int(text) {
                self.setQuantity(cell: cell, quantity: quantity)
            }
        }))
        self.present(alert, animated: true)
    }
    
    func showAlertError(title: String ,message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Set quantity item cart ***
    
    func setQuantity(cell: CartTableViewCell, quantity: Int) {
        guard let indexPath = tableView.indexPath(for: cell) else  { return }
        let cart = cartList[indexPath.row]
        if quantity > 100 {
            showAlertError(title: "Input error", message:  "Exceeded quantity allowed.")
            return
        }
        if quantity <= 0 {
            showAlertDeleteItem(cell: cell)
            return
        }
        let value = Int64(quantity) - cart.productQuantity
        if value == 0 {
            print("Value not change")
            return
        }
        if !CoreDataManager.share.updateCart(colorId: cart.productColorId!, quantity: quantity) {
            showAlertError(title: "Input error", message:  "Please try again.")
            return
        }
        if cart.isSelected
        {
            totalPrice += Int((value * cart.productPrice))
        }
        cart.productQuantity = Int64(quantity)
        cell.productQuantity.text = String(quantity)
    }
}

//MARK: - Handle value input alert
extension CartViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if Int(string) != nil || string == "" {
            if let text = textField.text, let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange, with: string)
                if updatedText.count <= 3 {
                    return true
                }
            }
        }
        return false
    }
}
