//
//  URLSessionProtocol.swift
//  ClearScore
//
//  Created by Ajay Odedra on 19/12/20.
//

import Foundation

typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Swift.Void

protocol URLSessionProtocol {
    func data(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol

}

extension URLSession: URLSessionProtocol {
    internal func data(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: url, completionHandler: completionHandler)
    }
}
