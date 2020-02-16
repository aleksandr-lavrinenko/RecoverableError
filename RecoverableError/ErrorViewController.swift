//
//  ErrorViewController.swift
//  RecoverableError
//
//  Created by Aleksandr Lavrinenko on 15.02.2020.
//  Copyright © 2020 Aleksandr Lavrinenko. All rights reserved.
//

import UIKit

final class ErrorViewController: UIViewController {
	// MARK: - Properties
	let service: ServiceInput = Service()

	// MARK: - UI
	@IBOutlet weak var showErrorButton: UIButton!
	@IBOutlet weak var tableView: UITableView! {
		didSet {
			tableView.backgroundView = UIView()
			tableView.separatorStyle = .none
		}
	}
	
	// MARK: - Actions
	@IBAction func didPressedErrorViewButton(_ button: UIButton) {
		requestFeed()
	}

	// MARK: Networking
	func requestFeed() {
		self.showErrorButton.isHidden = true
		service.requestObject { [weak self] (result) in
			guard let `self` = self else { return }
			switch result {
			case .success:
				break
			case .failure(let error):
				DispatchQueue.main.async {
					let recoverableError = RecoverableError(error: error, attempter: .tryAgainAttempter(block: {
						self.removeErrorView()
						self.showErrorButton.isHidden = false
						self.requestFeed()
					}))
					self.presentErrorView(from: recoverableError)
				}
			}
		}
	}
}

// MARK: - ErrorAlertCreatable
extension ErrorViewController: ErrorViewCreatable { }

// MARK: - ErrorAlertPresentable
extension ErrorViewController: ErrorViewAddable {
	var errorViewSuperview: UIView {
		return tableView
	}
}
