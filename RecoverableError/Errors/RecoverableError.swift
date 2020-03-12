//
//  RetryableError.swift
//  Recoverable
//
//  Created by Aleksandr Lavrinenko on 19.01.2020.
//  Copyright © 2020 Aleksandr Lavrinenko. All rights reserved.
//

import Foundation
import UIKit

struct RecoverableError {
	let error: Error
	let attempter: RecoveryAttemper

	var localizedError: LocalizedError? {
		return error as? LocalizedError
	}
}

// MARK: - Foundation.RecoverableError
extension RecoverableError: Foundation.RecoverableError {
	var recoveryOptions: [String] {
		return attempter.recoveryOptionsText
	}

	@discardableResult
	func attemptRecovery(optionIndex recoveryOptionIndex: Int) -> Bool {
		let recoverResult = attempter.attemptRecovery(fromError: error, optionIndex: recoveryOptionIndex)
		return recoverResult
	}

	func attemptRecovery(optionIndex: Int, resultHandler: (Bool) -> Void) {
		let recoverResult = attempter.attemptRecovery(fromError: error, optionIndex: optionIndex)
		resultHandler(recoverResult)
	}
}

// MARK: - LocalizedError
extension RecoverableError: LocalizedError {
	var errorDescription: String? {
		return localizedError?.errorDescription ?? "Something bad happened"
	}

	var recoverySuggestion: String? {
		return localizedError?.recoverySuggestion
	}
}
