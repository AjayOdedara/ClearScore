//
//  ScoreService.swift
//  ClearScore
//
//  Created by Ajay Odedra on 19/12/20.
//

import Foundation

class ScoreService: BaseService {
	
	func fetch (completionHandler: @escaping (Result<CreditScore, FetchError>) -> Void) {
		
		fetch(listOf: CreditScore.self, withURL: url(withPath: ServiceConstants.urls.score)) { (result) in
			switch result {
			case .success(let events):
				completionHandler(Result.success(events))
			case .failure(let error):
				completionHandler(Result.failure(error))
			}
		}
	}
}
