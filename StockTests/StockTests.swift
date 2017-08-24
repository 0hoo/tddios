
//
//  StockTests.swift
//  StockTests
//
//  Created by Kim Younghoo on 8/23/17.
//  Copyright © 2017 0hoo. All rights reserved.
//

import XCTest
@testable import Stock

final class StockTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testStockInit() {
        let stock = Stock(stockId: nil, code: "001100", name: "A", currentPrice: 15000, priceDiff: 100, rateDiff: 0.5, isPriceUp: true, isPriceKeep: false)
        XCTAssertNotNil(stock)
    }
    
    func testStockInitSetValues() {
        let stock = Stock(stockId: nil, code: "001100", name: "A", currentPrice: 15000, priceDiff: 100, rateDiff: 0.5, isPriceUp: true, isPriceKeep: false)
        XCTAssertEqual(stock.code, "001100") 
        XCTAssertEqual(stock.name, "A")
        XCTAssertEqual(stock.currentPrice, 15000)
    }
    
    func testStockQuantity() {
        let stock = Stock(stockId: nil, code: "001100", name: "A", currentPrice: 15000, priceDiff: 100, rateDiff: 0.5, isPriceUp: true, isPriceKeep: false)
        XCTAssertEqual(stock.quantity, 0)
        XCTAssertEqual(stock.value, 0)
        
        stock.quantity = 10
        XCTAssertEqual(stock.value, 15000 * 10)
    }
}











