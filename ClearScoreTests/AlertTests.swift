//
//  AlertTests.swift
//  ClearScore
//
//  Created by Ajay Odedra on 20/12/20.
//


import XCTest
@testable import ClearScore

class AlertTests: XCTestCase {
    
    func testAlert() {
        let expectAlertActionHandlerCall = expectation(description: "Alert action handler called")
        
        let alert = SingleButtonAlert(
            title: "",
            message: "",
            action: AlertAction(buttonTitle: "", handler: {
                expectAlertActionHandlerCall.fulfill()
            })
        )
        
        alert.action.handler!()
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
}
