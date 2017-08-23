import UIKit
import Alamofire
import Kanna

final class StocksViewController: UIViewController {
    
    var stocks: [Stock] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Stocks"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(StocksViewController.newStock))
        
        tableView?.dataSource = self
        tableView?.register(UINib(nibName: StockTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: StockTableViewCell.reuseIdentifier)
        tableView?.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 0))
        
        reload()
    }
    
    func newStock() {
        let alertController = UIAlertController(title: "주식", message: "종목 코드를 입력하세요", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "종목코드"
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            guard let stockCode = alertController.textFields?[0].text, !stockCode.isEmpty else { return }
            alertController.dismiss(animated: true, completion: nil)
            self.searchStock(stockCode: stockCode)
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    func searchStock(stockCode: String) {
        let siteUrl = "http://finance.daum.net/item/main.daum?code=" + stockCode
        Alamofire.request(siteUrl).responseString { response in
            guard let html = response.result.value else { return }
            guard let doc = HTML(html: html, encoding: .utf8) else { return }
            guard let nameElement = doc.at_css("#topWrap > div.topInfo > h2"), let name = nameElement.content else { return }
            guard let priceElement = doc.at_css("#topWrap > div.topInfo > ul.list_stockrate > li:nth-child(1) > em"), let priceString = priceElement.content else { return }
            guard let currentPrice = Double(priceString.replacingOccurrences(of: ",", with: "")) else { return }
            
            let priceKeep = priceElement.className?.hasSuffix("keep") == true
            let priceUp = priceElement.className?.hasSuffix("up") == true
            let priceDiffString = doc.at_css("#topWrap > div.topInfo > ul.list_stockrate > li:nth-child(2) > span")?.content ?? ""
            let priceDiff = Double(priceDiffString.replacingOccurrences(of: ",", with: "")) ?? 0
            var rateDiffString = doc.at_css("#topWrap > div.topInfo > ul.list_stockrate > li:nth-child(3) > span")?.content ?? ""
            if rateDiffString.hasSuffix("％") || rateDiffString.hasSuffix("%") {
                rateDiffString = rateDiffString.substring(to: rateDiffString.index(rateDiffString.startIndex, offsetBy: rateDiffString.characters.count - 1))
            }
            if rateDiffString.hasPrefix("+") || rateDiffString.hasPrefix("-") {
                rateDiffString = rateDiffString.substring(from: rateDiffString.index(rateDiffString.startIndex, offsetBy: 1))
            }
            let rateDiff = Double(rateDiffString.replacingOccurrences(of: ",", with: "")) ?? 0
            let stock = Stock(stockId: nil, code: stockCode, name: name, currentPrice: currentPrice, priceDiff: priceDiff, rateDiff: rateDiff, isPriceUp: priceUp, isPriceKeep: priceKeep)
            StockManager.save(stock)
            self.reload()
        }
    }
    
    func reload() {
        stocks = StockManager.findAll()
        tableView.reloadData()
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





