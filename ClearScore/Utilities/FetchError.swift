//
//  FetchError.swift
//  ClearScore
//
//  Created by Ajay Odedra on 19/12/20.
//

import Foundation

enum FetchError: Error {
	case invalidJSON
	case decodingError
	case invalidURL
	case networkFailed
}
