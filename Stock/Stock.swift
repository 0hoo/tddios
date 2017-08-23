import Foundation

final class Stock {
    
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
    
    init(code: String, name: String, currentPrice: Double, priceDiff: Double, rateDiff: Double, isPriceUp: Bool, isPriceKeep: Bool) {
        self.code = code
        self.name = name
        self.currentPrice = currentPrice
        self.priceDiff = priceDiff
        self.rateDiff = rateDiff
        self.isPriceUp = isPriceUp
        self.isPriceKeep = isPriceKeep
    }
}
