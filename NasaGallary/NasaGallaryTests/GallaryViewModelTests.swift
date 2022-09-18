//
//  GallaryViewModelTests.swift
//  NasaGallaryTests
//
//  Created by Jasvinder Singh on 18/09/22.
//

import XCTest
@testable import NasaGallary

class GallaryViewModelTests: XCTestCase {
    
    let viewModel: GallaryViewModel = GallaryViewModel()
    let dateCoverter: DateConverter = DateConverter()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGallaryViewModel_array_shouldBeEmpty() throws {
        XCTAssertFalse(viewModel.pictureArray.isEmpty)
        XCTAssertEqual(viewModel.pictureArray.count, 26)
    }
    
    func testFileRead() throws {
        let value = viewModel.readDataFromJsonFile(fileName: "data")
        XCTAssertNotNil(value)
        
        let wrongFile = viewModel.readDataFromJsonFile(fileName: "wrongfileName")
        XCTAssertNil(wrongFile)
    }
    
    func testStringToDateCoversion() throws {
        let value = dateCoverter.convertReceivedDateStringToDateObject(dateStr: "2022-09-18")
        XCTAssertNotNil(value)
        
        let wrongValue = dateCoverter.convertReceivedDateStringToDateObject(dateStr: "2022-September")
        XCTAssertNil(wrongValue)
    }
    
    func testDateToStringConversion() throws {
        let value = dateCoverter.convertDateObjectToDesiredDateString(date: Date())
        XCTAssertNotNil(value)
    }
    
    func testGetCurrentPictureObject_shouldNotContainObject() throws {
        let value = viewModel.getCurrentPictureObject(imageTitle: "test title")
        XCTAssertNil(value)
    }
    
    func testGetCurrentPictureObject_shouldContainObject() throws {
        let value = viewModel.getCurrentPictureObject(imageTitle: "Starburst Galaxy M94 from Hubble")
        XCTAssertNotNil(value)
    }
    
    func testGetIndexOfCurrentPictureObject_shouldContainObject() throws {
        let value = viewModel.getCurrentPictureObject(imageTitle: "M33: The Triangulum Galaxy")
        let item = viewModel.getIndexOfCurrentPictureObject(item: value)
        XCTAssertEqual(item, 0)
        XCTAssertNotEqual(item, -1)
    }
    
    func testGetIndexOfCurrentPictureObject_shouldNotContainObject() throws {
        let value = viewModel.getIndexOfCurrentPictureObject(item: nil)
        XCTAssertEqual(value, -1)
    }
}
