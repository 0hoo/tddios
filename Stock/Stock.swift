import Foundation

final class Stock {
    
    var stockId: Int64?
    let code: String
    let name: String
    let currentPrice: Double
    let priceDiff: Double
    let rateDiff: Double
    let isPriceUp: Bool
    let isPriceKeep: Bool
    var quantity = 0
    
    var value: Double {
        return currentPrice * Double(quantity)
    }
    
    var priceDiffText: String {
        if isPriceKeep {
            return "0 +0.00%"
        } else if isPriceUp {
            return "▲ \(priceDiff) +\(rateDiff)%"
        } else {
            return "▼ \(priceDiff) -\(rateDiff)%"
        }
    }
    
    init(stockId: Int64?, code: String, name: String, currentPrice: Double, priceDiff: Double, rateDiff: Double, isPriceUp: Bool, isPriceKeep: Bool) {
        self.stockId = stockId
        self.code = code
        self.name = name
        self.currentPrice = currentPrice
        self.priceDiff = priceDiff
        self.rateDiff = rateDiff
        self.isPriceUp = isPriceUp
        self.isPriceKeep = isPriceKeep
    }
}
