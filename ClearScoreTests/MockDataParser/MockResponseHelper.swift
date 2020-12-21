//
//  MockResponseHelper.swift
//  ClearScore
//
//  Created by Ajay Odedra on 20/12/20.
//

import Foundation

enum MockResponseType: String {
	case invalidJsonResponse = "CreditScoreInvalidResponse"
	case validJsonResponse = "CreditScoreValidResponse"
	case emptyJsonResponse = "CreditScoreEmptyResponse"
}

class MockResponseHelper {
	func processJsonData(for responseType: MockResponseType) -> Data {
		guard let path = Bundle(for: type(of: self)).url(forResource: responseType.rawValue, withExtension: "json"),
			let result = try? Data(contentsOf: path) else { return Data() }
		return result
	}
}
