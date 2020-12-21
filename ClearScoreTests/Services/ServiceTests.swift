//
//  ServiceTests.swift
//  ClearScore
//
//  Created by Ajay Odedra on 20/12/20.
//

import XCTest
import Foundation
@testable import ClearScore

class ServiceTests: XCTestCase {
	
	var sut: BaseService!
	var session = MockURLSession()
	let url = URL(string: "http://www.github.com")!
	var error: FetchError?
	
	override func setUp() {
		super.setUp()
		sut = BaseService(session: session)
		error = nil
	}
	
	func testSessionURL() {
		sut.fetch(listOf: CreditScore.self, withURL: url) { (_) in}
		XCTAssert(session.lastURL == url)
	}
	
	func testResponseError() {
		sut.fetch(listOf: CreditScore.self, withURL: url) { (result) in
			switch result {
			case .success(let events):
				XCTAssertNil(events)
			case .failure(let error):
				XCTAssertNotNil(error)
			}
		}
	}
	
	func testResumeCalled() {
		let dataTask = MockURLSessionDataTask()
		session.nextDataTask = dataTask
		
		sut.fetch(listOf: CreditScore.self, withURL: url) { (_) in}
		
		XCTAssert(dataTask.resumeWasCalled)
	}
	
	func testInvalidURL() {
		
		sut.fetch(listOf: CreditScore.self, withURL: nil) { (response) in
			switch response {
			case .failure(let error):
				XCTAssertEqual(error, FetchError.invalidURL)
			default: break
			}
		}
	}

	func testWithError() {
		session.nextError = .networkFailed
		sut.fetch(listOf: CreditScore.self, withURL: url) { (response) in
			switch response {
			case .failure(let error):
				XCTAssertEqual(error, .networkFailed)
			default: break
			}
		}
	}
	
	func testInvalidResponse() {
		
		let exp = expectation(description: "Got an Invalid response")

		session.nextData = MockResponseHelper().processJsonData(for: .invalidJsonResponse)
		sut.fetch(listOf: CreditScore.self, withURL: url) { (result) in
			switch result {
			case .success(let data):
				XCTAssertNil(data)
			case .failure(let error):
				XCTAssertTrue(error == .decodingError)
			}
			exp.fulfill()
		}
		
		waitForExpectations(timeout: 1.0, handler: nil)
	}
	
	func testValidResponse() {
		
		let exp = expectation(description: "Got valid response")

		session.nextData = MockResponseHelper().processJsonData(for: .validJsonResponse)
		sut.fetch(listOf: CreditScore.self, withURL: url) { (response) in
			switch response {
			case .success(let data):
				XCTAssertNotNil(data)
			case .failure(let error):
				XCTAssertNil(error)
			}
			exp.fulfill()
		}
		
		waitForExpectations(timeout: 1.0, handler: nil)
	}
	
}
