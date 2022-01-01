//
//  CoreDataStorageTest.swift
//  NewsAppTests
//
//  Created by Ahmed Ragab on 01/01/2022.
//

import XCTest
@testable import NewsApp

class CoreDataStorageTest: XCTestCase {
    
    
    var coreDataStack:CoreDataTestStack!
    var sut:UserCoreDataStorage!
    
    override func setUp() {
        
        coreDataStack  = CoreDataTestStack ()
        sut = UserCoreDataStorage(mainContext: coreDataStack.mainContext)
        super.setUp()
    }
    
    override class func tearDown() {
        
        super.tearDown()
    }
    
    
    func testAdd_User_toCoreData(){
        
        let res =  sut.CreateUser(user: StubGenerator.stubUsers())
        
        XCTAssertEqual(res?.email, "test@test.com")
    }
    
    func testFetch_useer_from_coreData(){
        sut.CreateUser(user: StubGenerator.stubUsers())
        sut.CreateUser(user: StubGenerator.stubUsers())
        let res = sut.fetchUser()
        
        do {
            
            let resArray  = try XCTUnwrap(res)
            XCTAssertNotNil(resArray.first)
            XCTAssertEqual(resArray.count, 2)
            XCTAssertNotEqual(resArray.count, 3)
            
        } catch let error {
            XCTFail("caanot unwrap optional wiith \(error.localizedDescription)")
        }
    }
    
    
    func testDelete_user_from_coreData(){
        sut.CreateUser(user: StubGenerator.stubUsers())
        sut.CreateUser(user: StubGenerator.stubUsers())
        let res = sut.fetchUser()

        
        do {
            
            let resArray  = try XCTUnwrap(res)
            XCTAssertEqual(resArray.count,1)
            sut.deleteUser(user: resArray[0])
            XCTAssertEqual(resArray.count,0)
            
        } catch let error {
            XCTFail("caanot unwrap optional wiith \(error.localizedDescription)")
        }
    }
    
}
