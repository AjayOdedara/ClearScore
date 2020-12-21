//
//  DashboardViewController.swift
//  ClearScore
//
//  Created by Ajay Odedra on 19/12/20.
//

import UIKit
import Combine

class DashboardViewController: UIViewController {
	
	@IBOutlet var scoreProgressView: ScoreProgressView!
	
	lazy var viewModel: ScoreViewModel = {
		let viewModel = ScoreViewModel()
		return viewModel
	}()
	
	private var cancellables: Set<AnyCancellable> = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		viewModel.fetchScore()
	}
	
	private func setupUI() {
		self.title = viewModel.title
		viewModel.viewDelegate = self
		scoreProgressView.scoreLabelSize = 40
		scoreProgressView.safePercent = 700
	}
}

// MARK: - Update Data
extension DashboardViewController: ScoreViewModelDelegate {
	
	func errorMessageDidChange(message: String) {
		let alert = SingleButtonAlert(title: DashboardConstants.AlertView.alertTitle,
									  message: message,
									  action: AlertAction(buttonTitle: DashboardConstants.AlertView.alertOkayButtonTitle, handler: {
										DLog("Alert action clicked")
									  }))
		GCD.runOnMainThread {
			self.presentSingleButtonDialog(alert: alert)
		}
	}
	
	func scoreDidChange() {
		DLog("Score Report Loaded")
		guard let report = viewModel.creditScoreData else { return }
		GCD.runOnMainThread {
			self.refreshTheUI(withScore: report)
		}
	}
	
	private func refreshTheUI(withScore data: CreditScore) {
		guard let currentScore = data.creditReportInfo?.score else { return }
		let scorePercent = Double ( currentScore * 1000 / 700 ) / 1000
		scoreProgressView.setScore(to: scorePercent, score: currentScore, withAnimation: true )
	}
}

// MARK: - Alert
extension DashboardViewController: SingleButtonDialogPresenter { }
