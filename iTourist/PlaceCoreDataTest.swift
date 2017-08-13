//
//  PlaceCoreDataTest.swift
//  iTourist
//
//  Created by Yevhen Roman on 8/13/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import XCTest
@testable import iTourist

class PlaceCoreDataTest: XCTestCase {
    //Class tested on String parameters, after test parameters were changed to String and [Data]
    let placeDataController = PlaceCoreData()
    
    func testAdding() {
        placeDataController.add(data: "11234", key: "564321")
    }
    func testFetch() {
        let placeData = placeDataController.get(by: "564321")
        XCTAssertEqual(placeData, "11234")
    }
    func testDelete() {
        placeDataController.add(data: "11234", key: "564321")
        XCTAssertEqual(placeDataController.delete(for: "564321"), true)
    }
    
}
