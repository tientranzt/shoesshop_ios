import UIKit

class CartViewController: UIViewController {
    //MARK: - Outlet + properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var totalItem: UILabel!
    @IBOutlet weak var btnCheckOut: UIButton!
    var countItem: Int = 0 {
        didSet {
            totalItem.text = "\(countItem) item"
        }
    }
    var countPrice: Int = 0 {
        didSet {
            totalPrice.text = "\(countPrice)$"
        }
    }
    var cartList: [Cart] = [Cart]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnCheckOut.roundedAllSide(with: 8)
//        CartModel.setDataTemp() // Delete after merge
        fetchData()
        configureTableView()
//        println(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString)
        print("Link data local: \(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as String)")
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
        cartList = CoreDataManager.share.fetchAllItemCart()
        countItem = CoreDataManager.share.getCountItemCartSelected()
        countPrice = CoreDataManager.share.getTotalPriceItemCartSelected()
        tableView.reloadData()
    }
    //MARK:- HANDLE ACTION CHECKOUT
    @IBAction func checkOutAction(_ sender: UIButton) {
        let modifiedVC = UIStoryboard(name: "Checkout", bundle: nil).instantiateViewController(identifier: "checkoutPage") as! CheckoutViewController
        
        navigationController?.pushViewController(modifiedVC, animated: true)
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
    
    //MARK:- Handle change shoeQuantity item
    
}

//MARK:- HANDLE CART CELL
extension CartViewController: CartTableViewCellDelegate {
    // protocol handle button plus
    func pressButtonPlus(cell: CartTableViewCell, didTapped button: UIButton?) {
        guard let text = cell.shoeQuantity.text else { return }
        if let quantity = Int(text) {
            setQuantity(cell: cell, quantity: quantity + 1)
        }
    }
    // protocol handle button minus
    func pressButtonMinus(cell: CartTableViewCell, didTapped button: UIButton?) {
        guard let text = cell.shoeQuantity.text else { return }
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
        let alert = UIAlertController(title: "Delete item", message: "[\(String(describing: cell.shoeName.text!))] \n Are you sure you want to delete this item ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in
            //update data
            guard let colorId = cart.shoeColorId else { return }
            if !CoreDataManager.share.deleteCart(colorId: colorId) {
                return
            }
            //remove row
            self.cartList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.reloadData()
            print("Delete success")
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Handle event checkbox
    func handleCheckBox(cell: CartTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else  { return }
        let cart = cartList[indexPath.row]
        if cart.isSelected {
            if !CoreDataManager.share.updateCart(colorId: cart.shoeColorId!, isChecked: false) {
                showAlertErrorQuantity(title: "Error", message:  "Please try again.")
                return
            }
            cart.isSelected = false
            cell.checkBox.isChecked = false
            countItem -= 1
            countPrice -= Int(cart.shoePrice * cart.shoeQuantity)
        } else {
            if !CoreDataManager.share.updateCart(colorId: cart.shoeColorId!, isChecked: true) {
                showAlertErrorQuantity(title: "Error", message:  "Please try again.")
                return
            }
            cart.isSelected = true
            cell.checkBox.isChecked = true
            countItem += 1
            countPrice += Int(cart.shoePrice * cart.shoeQuantity)
        }
    }
    
    //MARK: - Change quantity cart item
    func showAlertInputQuantity(cell: CartTableViewCell) {
        let alert = UIAlertController(title: "Input quantity", message: "[\(String(describing: cell.shoeName.text!))]", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        alert.addTextField(configurationHandler: { textField in
            textField.keyboardType = .numberPad
            textField.placeholder = cell.shoeQuantity.text
            textField.delegate = self // handle input
        })

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            guard let text = alert.textFields?.first?.text else {
                self.showAlertErrorQuantity(title: "Input error", message:  "Invalid quantity.")
                return
            }
            if let quantity = Int(text) {
                self.setQuantity(cell: cell, quantity: quantity)
            }
        }))
        self.present(alert, animated: true)
    }
    
    func showAlertErrorQuantity(title: String ,message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Set quantity item cart ***
    
    func setQuantity(cell: CartTableViewCell, quantity: Int) {
        guard let indexPath = tableView.indexPath(for: cell) else  { return }
        let cart = cartList[indexPath.row]
        if quantity > 100 {
            showAlertErrorQuantity(title: "Input error", message:  "Exceeded quantity allowed.")
            return
        }
        if quantity <= 0 {
            showAlertDeleteItem(cell: cell)
            return
        }
        let value = Int64(quantity) - cart.shoeQuantity
        if value == 0 {
            print("Value not change")
            return
        }
        if !CoreDataManager.share.updateCart(colorId: cart.shoeColorId!, quantity: quantity) {
            showAlertErrorQuantity(title: "Input error", message:  "Please try again.")
            return
        }
        if cart.isSelected
        {
            countPrice += Int((value * cart.shoePrice))
        }
        cart.shoeQuantity = Int64(quantity)
        cell.shoeQuantity.text = String(quantity)
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
