//
//  SnackBarTests.swift
//  SnackBarTests
//
//  Created by lee on 2021/06/01.
//

import XCTest
import RxSwift
import RxBlocking
@testable import SnackBar

class SnackBarTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMenuService() throws {
        let service = MenuService()

        do {
            let menus: [MenuItem] = try service.request(.menus, type: MenuResponse.self)
                .map(\.menus)
                .toBlocking()
                .single()

            XCTAssertEqual(menus.count, 19)
            XCTAssertEqual(menus.first?.name, "김말이")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
