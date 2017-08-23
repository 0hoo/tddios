import UIKit

final class StocksViewController: UIViewController {
    
    var stocks: [Stock] = [
        Stock(code: "001100", name: "삼성전자", currentPrice: 15000, priceDiff: 100, rateDiff: 0.5, isPriceUp: true, isPriceKeep: false)
    ]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Stocks"
        
        tableView?.dataSource = self
        tableView?.register(UINib(nibName: "StockTableViewCell", bundle: nil), forCellReuseIdentifier: "StockTableViewCell")
    }
}

extension StocksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StockTableViewCell") as! StockTableViewCell
        
        let stock = stocks[indexPath.row]
        cell.nameLabel?.text = stock.name
        
        return cell
    }
}






