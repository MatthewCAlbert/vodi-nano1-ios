//
//  RealmTest.swift
//  VODITests
//
//  Created by Matthew Christopher Albert on 28/04/22.
//

import XCTest
import RealmSwift
@testable import VODI

class RealmTest: XCTestCase {
    
    var sampleRepo: DraftInventoryItemRepository!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let config = Realm.Configuration(
            inMemoryIdentifier: "VODIRealmTest")
        self.sampleRepo = DraftInventoryItemRepository(configuration: config)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.sampleRepo = nil
        super.tearDown()
    }
    
    func test_asRealm() {
        let newItem = DraftInventoryItem(name: "Lila", price: 100, image: nil).asRealm()
        XCTAssertNotEqual(newItem.id.stringValue, "", "ID not found generated")
    }
    
    func test_insert() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let newItem = DraftInventoryItem(name: "Lila", price: 100, image: nil)
        
        let item = try awaitPublisher(self.sampleRepo.save(newItem))
        XCTAssertEqual(item.name, newItem.name, "Name not the same")
        XCTAssertNotEqual(item.id, "", "ID not found generated")
        print(item)
        
        let itemQueried = try awaitPublisher(self.sampleRepo.getOneById(item.id))
        XCTAssertEqual(itemQueried.name, newItem.name, "Name not the same")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
