//
//Project name: together
//
//Copyright © Gromov V.O., 2024
//

import XCTest
@testable import together


final class togetherTests: XCTestCase {

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
    
    func testDownloadSpeed() throws {
        let x = MeasureSpeedService()
            x.measureDownloadSpeed(serverURL: "https://google.com") { speed in
                print("Download speed ", speed)
            }
        RunLoop.main.run(until: .now + 5)
    }
    
    func testUploadSpeed() throws {
        let x = MeasureSpeedService()
        x.measureUploadSpeed(serverURL: "https://google.com", dataSize: 1000) { speed in
            print("Upload speed ", speed)
        }
        RunLoop.main.run(until: .now + 5)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
