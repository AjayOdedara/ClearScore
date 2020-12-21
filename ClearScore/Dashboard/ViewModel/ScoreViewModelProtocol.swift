//
//  ScoreViewModelProtoco.swift
//  ClearScore
//
//  Created by Ajay Odedra on 20/12/20.
//

import Foundation

protocol ScoreViewModelDelegate: class {
	func scoreDidChange()
	func errorMessageDidChange(message: String)
}

protocol ScoreViewModelProtocol {
	var title: String { get }
	var creditScoreData: CreditScore? { get set }
	var errorMessage: String { get set }
	func fetchScore()
	
	var viewDelegate: ScoreViewModelDelegate? { get set }
}
