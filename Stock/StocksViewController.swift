import UIKit

final class StocksViewController: UIViewController {
    
    var stocks: [Stock] = [
        //Stock(code: "001100", name: "삼성전자", currentPrice: 15000, priceDiff: 100, rateDiff: 0.5, isPriceUp: true, isPriceKeep: false)
    ]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Stocks"
        
        tableView?.dataSource = self
        tableView?.register(UINib(nibName: StockTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: StockTableViewCell.reuseIdentifier)
        tableView?.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 0))
    }
}

extension StocksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockTableViewCell.reuseIdentifier) as! StockTableViewCell
        
        let stock = stocks[indexPath.row]
        cell.stock = stock
        
        return cell
    }
}

extension StocksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return StockTableViewCell.height
    }
}





