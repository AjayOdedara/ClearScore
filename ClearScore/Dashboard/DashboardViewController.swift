//
//  DashboardViewController.swift
//  ClearScore
//
//  Created by Ajay Odedra on 19/12/20.
//

import UIKit
import Combine

class DashboardViewController: UIViewController {
	
	lazy var viewModel: ScoreViewModel = {
		let viewModel = ScoreViewModel()
		return viewModel
	}()
	
	private var cancellables: Set<AnyCancellable> = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel.fetchScore()
	}
	
	private func bindViewModel() {
		
		viewModel.$scoreReport.sink { [self] _ in
			switch viewModel.scoreReport {
			case .data(model: let scoreReport):
				DLog("Got Successfull Response")
				GCD.runOnMainThread {
					refreshTheUI(withScore: scoreReport)
				}
			default:
				DLog("Something went wrong or still Idle")
			}
		}.store(in: &cancellables)
		
		viewModel.$onShowError.sink { [self] _ in
			DLog("Error Alert")
			GCD.runOnMainThread {
				presentSingleButtonDialog(alert: viewModel.onShowError!)
			}
		}.store(in: &cancellables)
		
	}
	
	private func setupUI() {
		
	}
	
	private func refreshTheUI(withScore score: Score) {
		print("refreshTheUI")
	}
}

// MARK: - Alert
extension DashboardViewController: SingleButtonDialogPresenter { }
