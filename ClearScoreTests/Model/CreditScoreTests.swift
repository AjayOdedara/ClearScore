//
//  CreditScoreTests.swift
//  ClearScore
//
//  Created by Ajay Odedra on 20/12/20.
//



import XCTest
@testable import ClearScore

class CreditScoreTests: XCTestCase {

	var creditScore: CreditScore? {
		return DecodableHelper.decode(CreditScore.self, dictionary: creditScoreDataPresentation())
	}

	func testInitializationWithRepresentation() {
		XCTAssertNotNil(creditScore)
	}

	func testInitializationWithNoImagePathRepresentation() {
		let productDataNilImagePresentation = [
			"id": "5d4aab8b4ada8fca84541eee",
			"title": "Morton Orr",
			"price": "Â£199"
		] as [String: Any]

		XCTAssertNil(DecodableHelper.decode(CreditScore.self, dictionary: productDataNilImagePresentation))
	}

	func testNameDescriptionAndThumbnail() throws {
		let creditScore = try XCTUnwrap(self.creditScore)
		
		XCTAssertTrue(creditScore.accountIDVStatus == "PASS")
		XCTAssertTrue(creditScore.dashboardStatus == "PASS")
		XCTAssertTrue(creditScore.creditReportInfo?.score == 514)
		XCTAssertTrue(creditScore.creditReportInfo?.maxScoreValue == 700)
	}

}

extension CreditScoreTests {

	private func creditScoreDataPresentation() -> [String: Any] {
		let representation = [
				"accountIDVStatus":"PASS",
				"creditReportInfo":
				[
					"score":514,
					"scoreBand":4,
					"clientRef":"CS-SED-655426-708782",
					"status":"MATCH",
					"maxScoreValue":700,
					"minScoreValue":0,
					"monthsSinceLastDefaulted":-1,
					"hasEverDefaulted":false,
					"monthsSinceLastDelinquent":1,
					"hasEverBeenDelinquent":true,
					"percentageCreditUsed":44,
					"percentageCreditUsedDirectionFlag":1,
					"changedScore":0,
					"currentShortTermDebt":13758,
					"currentShortTermNonPromotionalDebt":13758,
					"currentShortTermCreditLimit":30600,
					"currentShortTermCreditUtilisation":44,
					"changeInShortTermDebt":549,
					"currentLongTermDebt":24682,
					"currentLongTermNonPromotionalDebt":24682,
					"currentLongTermCreditLimit":nil,
					"currentLongTermCreditUtilisation":nil,
					"changeInLongTermDebt":-327,
					"numPositiveScoreFactors":9,
					"numNegativeScoreFactors":0,
					"equifaxScoreBand":4,
					"equifaxScoreBandDescription":"Excellent",
					"daysUntilNextReport":9
					
				],
				
				"dashboardStatus":"PASS",
				"personaType":"INEXPERIENCED",
				"coachingSummary":
				[
					"activeTodo":false,
					"activeChat":true,
					"numberOfTodoItems":0,
					"numberOfCompletedTodoItems":0,
					"selected":true
					
				],
				"augmentedCreditScore":nil
		] as [String: Any?]
		return representation
	}
}
