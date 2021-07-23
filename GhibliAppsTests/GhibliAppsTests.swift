//
//  GhibliAppsTests.swift
//  GhibliAppsTests
//
//  Created by Gus Adi on 22/07/21.
//

import XCTest
import Combine
@testable import GhibliApps

class GhibliAppsTests: XCTestCase {
    private var subject: HomeViewModel!
    private var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        subject = HomeViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cancellables.forEach { $0.cancel() }
    
        subject = nil
        
        super.tearDown()
    }

    func test_isarrayfillmempty() throws {
        
        XCTAssertTrue(subject.films.isEmpty)
    }

}
