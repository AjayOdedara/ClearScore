//
//  Score.swift
//  ClearScore
//
//  Created by Ajay Odedra on 19/12/20.
//

import Foundation

// MARK: - CreditScore
struct CreditScore: Codable {
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
}
