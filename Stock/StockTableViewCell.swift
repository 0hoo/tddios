import UIKit

final class StockTableViewCell: UITableViewCell {
    
    static let height = CGFloat(60)
    
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var priceLabel: UILabel?
    @IBOutlet weak var ratioLabel: UILabel?
    
    var stock: Stock? {
        didSet {
            guard let stock = stock else { return }
            
            nameLabel?.text = stock.name
            
            var priceText = "\(stock.currentPrice)"
            priceLabel?.text = priceText
            priceText += "   \(stock.priceDiffText)"
            if stock.isPriceKeep {
                priceLabel?.textColor = .black
            } else if stock.isPriceUp {
                priceLabel?.textColor = .red
            } else {
                priceLabel?.textColor = .blue
            }
            priceLabel?.text = priceText
        }
    }
}
