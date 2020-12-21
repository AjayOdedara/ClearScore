//
//  MockURLSessionDataTask.swift
//  ClearScore
//
//  Created by Ajay Odedra on 20/12/20.
//



import Foundation
@testable import ClearScore

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
    
    func cancel() {
        
    }
}
