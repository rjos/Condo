//
//  CondoModelTests.swift
//  CondoModelTests
//
//  Created by Lucas Tenório on 09/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import XCTest

class CondoModelTests: XCTestCase {
    
    var database: DummyDatabase? = nil
    
    override func setUp() {
        super.setUp()
        self.database = DummyDatabase()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.database = nil
        super.tearDown()
    }
    
    func testCommunityPosts() {
        XCTAssertNotNil(self.database, "Database is Nil")
        let community = self.database!.community
        let posts = community.posts
        for x in 0 ..< posts.count() {
            XCTAssertNotNil(posts.modelAtIndex(x), "Post is nil")
        }
    }
    
    func testCommunityAdministrators() {
        XCTAssertNotNil(self.database, "Database is Nil")
        let community = self.database!.community
        let adms = community.administrators
        for x in 0 ..< adms.count() {
            XCTAssertNotNil(adms.modelAtIndex(x), "Adm is nil")
        }
    }
    func testCommunityExpenses() {
        XCTAssertNotNil(self.database, "Database is Nil")
        let community = self.database!.community
        let expenses = community.expenses
        for x in 0 ..< expenses.count() {
            XCTAssertNotNil(expenses.modelAtIndex(x), "Adm is nil")
        }
    }
    
}
