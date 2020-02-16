//
//  ViewController.swift
//  RecoverableError
//
//  Created by Aleksandr Lavrinenko on 13.01.2020.
//  Copyright © 2020 Aleksandr Lavrinenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	let service: ServiceInput = Service()

	// MARK: - Actions 
	@IBAction func didPressedInternetErrorButton(_ button: UIButton) {
		requestFeed()
	}

	@IBAction func didPressedNotEnoughSpaceButton(_ button: UIButton) {
		runOutOfSpace()
	}

	// MARK: Networking
	func requestFeed() {
		service.requestObject { [weak self] (result) in
			guard let `self` = self else { return }
			switch result {
			case .success:
				break
			case .failure(let error):
				DispatchQueue.main.async {
					let recoverableError = RecoverableError(error: error, attempter: .tryAgainAttempter(block: {
						self.requestFeed()
					}))
					self.presentAlert(from: recoverableError)
				}
			}
		}
	}

	func runOutOfSpace() {
		service.runOfSpace { [weak self] (result) in
			guard let `self` = self else { return }
			switch result {
			case .success:
				break
			case .failure(let error):
				DispatchQueue.main.async {
					let notEnoughSpace = RecoveryOptions.freeSpace {
						self.freeSpace()
					}
					let buyMoreSpace = RecoveryOptions.buyMoreSpace {
						self.buyMoreSpace()
					}
					let options = [notEnoughSpace, buyMoreSpace]
					let recoverableError = RecoverableError(error: error, attempter: .cancalableAttemter(options: options))
					self.presentAlert(from: recoverableError)
				}
			}
		}
	}

	// MARK: - Result handlers
	func freeSpace() {
		let alertViewController = createOKAlert(with: "Free space selected")
		present(alertViewController, animated: true, completion: nil)
	}

	func buyMoreSpace() {
		let alertViewController = createOKAlert(with: "Buy more space selected")
		present(alertViewController, animated: true, completion: nil)
	}
}


// MARK: - ErrorAlertCreatable
extension ViewController: ErrorAlertCreatable { }

// MARK: - ErrorAlertPresentable
extension ViewController: ErrorAlertPresentable { }
