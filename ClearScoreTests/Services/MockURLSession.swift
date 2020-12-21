//
//  MockURLSession.swift
//  ClearScore
//
//  Created by Ajay Odedra on 20/12/20.
//



import XCTest
import Foundation
@testable import ClearScore

class MockURLSession: URLSessionProtocol {
    private (set) var lastURL: URL?
    var nextDataTask = MockURLSessionDataTask()
    var nextResponse: HTTPURLResponse?
    var nextData: Data?
    var nextError: FetchError?
    
    func data(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        lastURL = url
        completionHandler(nextData, nextResponse, nextError)
        return nextDataTask
    }
}
