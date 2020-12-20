//
//  ScoreViewModel.swift
//  ClearScore
//
//  Created by Ajay Odedra on 19/12/20.
//

import Foundation
import Combine

class ScoreViewModel {
	
	enum EventViewCellType {
		case idle
		case data(model: Score)
	}
	
	@Published var scoreReport: EventViewCellType = .idle
	@Published var onShowError: SingleButtonAlert?
	
	private let scoreService: ScoreService
	
	init(withScoreService scoreService: ScoreService = ScoreService()) {
		self.scoreService = scoreService
	}
	
	func fetchScore() {
		scoreService.fetch { [weak self] (result) in
			switch result {
			case .success(let response):
				self?.scoreReport = .data(model: response)
			case .failure(let error):
				DLog(error.localizedDescription)
				let alert = SingleButtonAlert(title: "EventViewConstants.AlertView.alertTitle",
											  message: error.localizedDescription,
											  action: AlertAction(buttonTitle: "EventViewConstants.AlertView.alertOkayButtonTitle", handler: {
												DLog("Alert action clicked")
											  }))
				self?.onShowError = alert
			}
		}
	}
}

