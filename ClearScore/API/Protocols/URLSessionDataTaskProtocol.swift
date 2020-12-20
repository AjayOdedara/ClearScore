//
//  URLSessionDataTaskProtocol.swift
//  ClearScore
//
//  Created by Ajay Odedra on 19/12/20.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
    func cancel()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol { }
