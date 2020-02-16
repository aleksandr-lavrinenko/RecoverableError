//
//  ErrorAlertAddable.swift
//  Recoverable
//
//  Created by Aleksandr Lavrinenko on 02.02.2020.
//  Copyright © 2020 Aleksandr Lavrinenko. All rights reserved.
//

import Foundation
import CoreGraphics

protocol ErrorViewCreatable: ErrorReasonExtractable {
	func createErrorView(for error: Error) -> ErrorView
}

// MARK: - Default implementation
extension ErrorViewCreatable {
	func createErrorView(for error: Error) -> ErrorView {
		if let recoverableError = error as? RecoverableError {
			return createRecoverableAlert(for: recoverableError)
		}

		let defaultTitle = "Error"
		let description = errorReason(from: error)
		if let localizedError = error as? LocalizedError {
			return createErrorView(
				title: localizedError.errorDescription ?? defaultTitle,
				message: description)
		}


		return createErrorView(title: defaultTitle, message: description)
	}

	fileprivate func createErrorView(title: String?, message: String?, actions: [ErrorView.Action] = []) -> ErrorView {
		return ErrorView(title: title, description: message, actions: actions)
	}

	fileprivate func createRecoverableAlert(for recoverableError: RecoverableError) -> ErrorView {
		let title = recoverableError.errorDescription
		let message = errorReason(from: recoverableError)
		let actions = recoverableError.recoveryOptions.enumerated().map { (element) -> ErrorView.Action in
			return ErrorView.Action(title: element.element) {
				recoverableError.attemptRecovery(optionIndex: element.offset)
			}
		}
		return createErrorView(title: title, message: message, actions: actions)
	}
}
