//
//  ScreensketchUITests.swift
//  ScreensketchUITests
//
//  Created by Ricardo Pereira on 27/07/16.
//  Copyright © 2016 Ricardo Pereira. All rights reserved.
//

import XCTest

class ScreensketchUITests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launchArguments = ["IS_UI_TESTING"]
        setupSnapshot(app)
        app.launch()
    }

    func testScreenshotsList() {
        /* Not working!
        let app = XCUIApplication()

        addUIInterruptionMonitorWithDescription("“Screensketch” Would Like to Access Your Photos") {
            $0.buttons["Ok"].tap()
            return true
        }

        app.tap()
        let albumAccessAlert = app.alerts["“Screensketch” Would Like to Access Your Photos"]
        let exists = NSPredicate(format: "exists == true")
        expectationForPredicate(exists, evaluatedWithObject: albumAccessAlert, handler: nil)
        waitForExpectationsWithTimeout(5, handler: nil)
        if albumAccessAlert.exists {
            albumAccessAlert.collectionViews.buttons["OK"].tap()
        }
        */
        snapshot("Init")
    }

    func testDraw() {
        let app = XCUIApplication()
        // FIXME: waitForExpectationsWithTimeout
        let element = app.collectionViews.cells.elementBoundByIndex(app.collectionViews.cells.count-1)
        element.tap()
        snapshot("DrawInScreenshot")
    }

    func testShareDraw() {
        let app = XCUIApplication()
        // FIXME: waitForExpectationsWithTimeout
        let element = app.collectionViews.cells.elementBoundByIndex(app.collectionViews.cells.count-1)
        element.tap()
        app.buttons["Share Button"].tap()
        snapshot("ShareScreenshot")
    }

}
