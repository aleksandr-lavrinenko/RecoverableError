//
//  ErrorAlertCreatable.swift
//  Recoverable
//
//  Created by Aleksandr Lavrinenko on 13.01.2020.
//  Copyright © 2020 Aleksandr Lavrinenko. All rights reserved.
//

import UIKit

protocol ErrorAlertCreatable: class, ErrorReasonExtractable {
	func createAlert(for error: Error, aboveAll: Bool) -> UIAlertController
	func createOKAlert(with text: String) -> UIAlertController
}

// MARK: - Default implementation
extension ErrorAlertCreatable where Self: UIViewController {
	func createAlert(for error: Error, aboveAll: Bool) -> UIAlertController {
		if let recoverableError = error as? RecoverableError {
			return createRecoverableAlert(for: recoverableError, aboveAll: aboveAll)
		}
		let defaultTitle = "Error"
		let description = errorReason(from: error)
		if let localizedError = error as? LocalizedError {
			return createAlert(
				title: localizedError.errorDescription ?? defaultTitle,
				message: description,
				actions: [.okAction],
				aboveAll: aboveAll)
		}

		return createAlert(title: defaultTitle, message: description, actions: [.okAction], aboveAll: aboveAll)
	}

	fileprivate func createAlert(title: String?, message: String?, actions: [UIAlertAction], aboveAll: Bool) -> UIAlertController {
		let alertViewController = aboveAll ?
			AboveAllAlertController(title: title, message: message, preferredStyle: .alert) :
			UIAlertController(title: title, message: message, preferredStyle: .alert)
		actions.forEach({ alertViewController.addAction($0) })
		return alertViewController
	}

	fileprivate func createRecoverableAlert(for recoverableError: RecoverableError, aboveAll: Bool) -> UIAlertController {
		let title = recoverableError.errorDescription
		let message = errorReason(from: recoverableError)
		let actions = recoverableError.recoveryOptions.enumerated().map { (element) -> UIAlertAction in
			let style: UIAlertAction.Style = element.offset == 0 ? .cancel : .default
			return UIAlertAction(title: element.element, style: style) { _ in
				recoverableError.attemptRecovery(optionIndex: element.offset)
			}
		}
		return createAlert(title: title, message: message, actions: actions, aboveAll: aboveAll)
	}

	func createOKAlert(with text: String) -> UIAlertController {
		return createAlert(title: text, message: nil, actions: [.okAction], aboveAll: false)
	}
}

// MARK: - Ok alert action
extension UIAlertAction {
	static let okAction = UIAlertAction(title: "OK", style: .cancel) { (_) -> Void in }
}

