import UIKit

class CartViewController: UIViewController {
    //MARK: - Outlet + properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var totalItem: UILabel!
    @IBOutlet weak var btnCheckOut: UIButton!
    
    var cartList :[Cart] = [Cart]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnCheckOut.roundedAllSide(with: 8)
//        fetchData()
        configureTableView()
        print("Link data local: \(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)")
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
        tableView.reloadData()
    }
    
    func deleteUserContact(shoeColorId: String)  {
        CoreDataManager.share.deleteCart(colorId: shoeColorId)
    }

}
//MARK: - Extension TableView Delegate + Datasource
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as! CartTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
//        set the delegate to self
        cell.cellDelegate = self
//        set data for cell
//        cell.setData(cartItem: cartList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
    
    //MARK:- Handle change quantity item
    
}

//MARK:- HANDLE CART CELL
extension CartViewController: CartTableViewCellDelegate {

    func pressButtonPlus(cell: CartTableViewCell, didTapped button: UIButton?) {
        guard let text = cell.quantityShoe.text else { return }
        if let quantity = Int(text) {
            setQuantity(cell: cell, quantity: quantity + 1)
        }
    }
    
    func pressButtonMinus(cell: CartTableViewCell, didTapped button: UIButton?) {
        guard let text = cell.quantityShoe.text else { return }
        if let quantity = Int(text) {
            setQuantity(cell: cell, quantity: quantity - 1)
        }
    }
    
    func pressLabelQuantity(cell: CartTableViewCell) {
        showAlertInputQuantity(cell: cell)
    }
    
    
    //MARK: - Delete cart item via Alert confirm
    func showAlertDeleteItem(cell: CartTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else  { return }
        let alert = UIAlertController(title: "Xoá vật phẩm", message: "Bạn có chắc muốn xoá [\(String(describing: cell.nameShoe.text!))] ra khỏi giỏ hàng không?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Có", style: .default, handler: { action in
            //update data
            //remove row
//            carts.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
//            self.tableView.reloadData()
            print("Đồng ý xoá vật phẩm")
        }))
        alert.addAction(UIAlertAction(title: "Không", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Change quantity cart item
    
    func showAlertInputQuantity(cell: CartTableViewCell) {
        let alert = UIAlertController(title: "Nhập số lượng", message: "[\(String(describing: cell.nameShoe.text!))]", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Huỷ", style: .cancel, handler: nil))

        alert.addTextField(configurationHandler: { textField in
            textField.keyboardType = .numberPad
            textField.placeholder = cell.quantityShoe.text
            textField.delegate = self // handle input
        })

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            guard let text = alert.textFields?.first?.text else {
                self.showAlertErrorQuantity(title: "Lỗi nhập liệu", message:  "Số lượng không hợp lệ.")
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
    
    //MARK: - Set quantity item cart
    
    func setQuantity(cell: CartTableViewCell, quantity: Int) {
        if quantity > 100 {
            showAlertErrorQuantity(title: "Lỗi nhập liệu", message:  "Vượt quá số lượng cho phép.")
            return
        }
        if quantity <= 0 {
            showAlertDeleteItem(cell: cell)
            return
        }
        cell.quantityShoe.text = String(quantity)
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
