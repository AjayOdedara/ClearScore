//
//  ScoreViewModel.swift
//  ClearScore
//
//  Created by Ajay Odedra on 19/12/20.
//

import Foundation

class ScoreViewModel: ScoreViewModelProtocol {
	
	var title: String {
		return "Dashboard"
	}
	
	var creditScoreData: CreditScore? {
		didSet {
			viewDelegate?.scoreDidChange()
		}
	}
	/// Errors
	var errorMessage: String = "" {
		didSet {
			if oldValue != errorMessage {
				viewDelegate?.errorMessageDidChange(message: errorMessage)
			}
		}
	}
	
	let scoreService: ScoreService
	weak var viewDelegate: ScoreViewModelDelegate?
	
	init(withScoreService scoreService: ScoreService = ScoreService()) {
		self.scoreService = scoreService
	}
	
	func fetchScore() {
		scoreService.fetch { [self] (result) in
			switch result {
			case .success(let response):
				print("Data = ", response)
				creditScoreData = response
			case .failure(let error):
				DLog(error.localizedDescription)
				errorMessage = error.localizedDescription
			}
		}
	}
}
