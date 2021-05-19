import UIKit

class SearchTableViewController: UITableViewController {

    var listFilteredProduct : [ProductModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "SearchResultTableViewCell", bundle: nil), forCellReuseIdentifier: "searchCell")
        tableView.rowHeight = 85
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
   
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let filterProductList = listFilteredProduct else {
            return 1
        }
        
        return filterProductList.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchResultTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        guard let filterProductList = listFilteredProduct else {
            return cell
        }
        
        cell.initCell(product: filterProductList[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = UIStoryboard(name: "DetailProduct", bundle: nil).instantiateViewController(identifier: "detailViewController") as! DetailProductViewController

        detailVC.product = listFilteredProduct![indexPath.row]
        detailVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
