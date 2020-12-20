//
//  Score.swift
//  ClearScore
//
//  Created by Ajay Odedra on 19/12/20.
//

import Foundation


struct ServiceResponse {
	
	let result: [String: Any]
	
	init?(_ data: Data?) {
		guard let theData = data,
			let json = try? JSONSerialization
				.jsonObject(with: theData, options: JSONSerialization.ReadingOptions(rawValue: 0)),
			let jsonRep = json as? [String: Any],
			let data = jsonRep["data"] as? [String: Any],
			let result = data["results"] as? [String: Any]
//			let offset = data["offset"] as? Int,
//			let count = data["count"] as? Int,
//			let total = data["total"] as? Int
		else {
				return nil
		}
	
		self.result = result
//		self.offset = offset
//		self.count = count
//		self.total = total
	}
}

// MARK: - Score
struct Score: Codable {
	let accountIDVStatus: String
	let creditReportInfo: CreditReportInfo?
	let dashboardStatus, personaType: String
	let coachingSummary: CoachingSummary
	let augmentedCreditScore: String?
}

// MARK: - CoachingSummary
struct CoachingSummary: Codable {
	let activeTodo, activeChat: Bool
	let numberOfTodoItems, numberOfCompletedTodoItems: Int
	let selected: Bool
}

// MARK: - CreditReportInfo
struct CreditReportInfo: Codable {
	let score, scoreBand: Int
	let clientRef, status: String
	let maxScoreValue, minScoreValue, monthsSinceLastDefaulted: Int
	let hasEverDefaulted: Bool
	let monthsSinceLastDelinquent: Int
	let hasEverBeenDelinquent: Bool
	let percentageCreditUsed, percentageCreditUsedDirectionFlag, changedScore, currentShortTermDebt: Int
	let currentShortTermNonPromotionalDebt, currentShortTermCreditLimit, currentShortTermCreditUtilisation, changeInShortTermDebt: Int
	let currentLongTermDebt, currentLongTermNonPromotionalDebt: Int
	let currentLongTermCreditLimit, currentLongTermCreditUtilisation: String?
	let changeInLongTermDebt, numPositiveScoreFactors, numNegativeScoreFactors, equifaxScoreBand: Int
	let equifaxScoreBandDescription: String
	let daysUntilNextReport: Int
	
//	enum CodingKeys: String, CodingKey {
//		case score, maxScoreValue, minScoreValue
//	}
}
