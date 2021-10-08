//
//  NewsAppBarakaUITests.swift
//  NewsAppBarakaUITests
//
//  Created by Abdul Rahim on 07/10/21.
//

import XCTest

class NewsAppBarakaUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    //test for top layout
    func test_top_section_collection_view() {
        
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        let scrollView = collectionViewsQuery.children(matching: .scrollView).element(boundBy: 0)
        let cellsQuery = scrollView.cells
        cellsQuery.children(matching: .other).element.children(matching: .other).element.swipeUp()
        
        let donTLoseYourHopeAfghanGirlsRoboticsTeamSpeaksFromSafetyInMexicoStaticText = cellsQuery.staticTexts["'Don't lose your hope': Afghan girls robotics team speaks from safety in Mexico"]
        donTLoseYourHopeAfghanGirlsRoboticsTeamSpeaksFromSafetyInMexicoStaticText.swipeUp()
        donTLoseYourHopeAfghanGirlsRoboticsTeamSpeaksFromSafetyInMexicoStaticText.tap()
        scrollView.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.tap()
        donTLoseYourHopeAfghanGirlsRoboticsTeamSpeaksFromSafetyInMexicoStaticText.tap()
        app/*@START_MENU_TOKEN@*/.otherElements["URL"]/*[[".otherElements[\"BrowserView?WebViewProcessID=17230\"]",".otherElements[\"TopBrowserBar\"]",".buttons[\"Address\"]",".otherElements[\"Address\"]",".otherElements[\"URL\"]",".buttons[\"URL\"]"],[[[-1,4],[-1,3],[-1,5,3],[-1,2,3],[-1,1,2],[-1,0,1]],[[-1,4],[-1,3],[-1,5,3],[-1,2,3],[-1,1,2]],[[-1,4],[-1,3],[-1,5,3],[-1,2,3]],[[-1,4],[-1,3]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let justFourYearsAgoTheHalfDozenTeenageGirlsFromAfghanistanStrodeConfidentlyIntoCompetitionWavingTheirCountrySFlagStaticText = cellsQuery.staticTexts["Just four years ago, the half dozen teenage girls from Afghanistan strode confidently into competition, waving their country's flag."]
        justFourYearsAgoTheHalfDozenTeenageGirlsFromAfghanistanStrodeConfidentlyIntoCompetitionWavingTheirCountrySFlagStaticText.swipeLeft()
        justFourYearsAgoTheHalfDozenTeenageGirlsFromAfghanistanStrodeConfidentlyIntoCompetitionWavingTheirCountrySFlagStaticText.swipeLeft()
        
        let element = scrollView.children(matching: .cell).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element
        element.swipeLeft()
        element.swipeLeft()
        element.swipeLeft()
        element.swipeLeft()
        collectionViewsQuery.scrollViews.cells.staticTexts["Just four years ago, the half dozen teenage girls from Afghanistan strode confidently into competition, waving their country's flag."].swipeUp()
        collectionViewsQuery.staticTexts["Middle section horizontal scroll"].swipeUp()
        
        let scrollView2 = collectionViewsQuery.children(matching: .scrollView).element(boundBy: 1)
        scrollView2.cells.staticTexts["'Don't lose your hope': Afghan girls robotics team speaks from safety in Mexico"].swipeLeft()
        scrollView2.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.swipeLeft()
        
        let cellsQuery2 = collectionViewsQuery/*@START_MENU_TOKEN@*/.cells/*[[".scrollViews.cells",".cells"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        cellsQuery2.staticTexts["Megan C. Hills, CNN"].swipeLeft()
        
        let element3 = scrollView2.children(matching: .cell).element(boundBy: 2).children(matching: .other).element.children(matching: .other).element
        let element2 = element3.children(matching: .other).element
        element2.swipeLeft()
        element2.swipeLeft()
        element2.swipeLeft()
        element2.swipeLeft()
        element2.swipeLeft()
        element2.swipeLeft()
        
    }
    
    // test for bottom collection layout
    func test_collectionview_bottom() {
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        let top100NewsStaticText = collectionViewsQuery.staticTexts["Top 100 News"]
        top100NewsStaticText.swipeUp()
        top100NewsStaticText/*@START_MENU_TOKEN@*/.swipeRight()/*[[".swipeUp()",".swipeRight()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        collectionViewsQuery.children(matching: .cell).element(boundBy: 0).staticTexts["'Don't lose your hope': Afghan girls robotics team speaks from safety in Mexico"].tap()
        app/*@START_MENU_TOKEN@*/.otherElements["URL"]/*[[".otherElements[\"BrowserView?WebViewProcessID=17393\"]",".otherElements[\"TopBrowserBar\"]",".buttons[\"Address\"]",".otherElements[\"Address\"]",".otherElements[\"URL\"]",".buttons[\"URL\"]"],[[[-1,4],[-1,3],[-1,5,3],[-1,2,3],[-1,1,2],[-1,0,1]],[[-1,4],[-1,3],[-1,5,3],[-1,2,3],[-1,1,2]],[[-1,4],[-1,3],[-1,5,3],[-1,2,3]],[[-1,4],[-1,3]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
