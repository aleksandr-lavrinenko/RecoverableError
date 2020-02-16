//
//  ErrorAlertPresentable.swift
//  Recoverable
//
//  Created by Aleksandr Lavrinenko on 31.01.2020.
//  Copyright © 2020 Aleksandr Lavrinenko. All rights reserved.
//

import UIKit

protocol ErrorAlertPresentable: class {
	func presentAlert(from error: Error)
	func presentAlertAboveAll(from error: Error)
}

// MARK: - Default implementation
extension ErrorAlertPresentable where Self: ErrorAlertCreatable & UIViewController {
	func presentAlert(from error: Error) {
		let alertVC = createAlert(for: error, aboveAll: false)
		present(alertVC, animated: true, completion: nil)
	}

	func presentAlertAboveAll(from error: Error) {
		let alertVC = createAlert(for: error, aboveAll: true)
		if let alertVC = alertVC as? AboveAllAlertController {
			alertVC.show()
			return
		}
		assert(false, "Should create AboveAllAlertController")
		present(alertVC, animated: true, completion: nil)
	}
}
