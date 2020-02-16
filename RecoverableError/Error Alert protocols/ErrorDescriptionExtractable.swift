//
//  ErrorDescriptionExtractable.swift
//  RecoverableError
//
//  Created by Aleksandr Lavrinenko on 15.02.2020.
//  Copyright © 2020 Aleksandr Lavrinenko. All rights reserved.
//

import Foundation

protocol ErrorReasonExtractable {
	func errorReason(from error: Error) -> String?
}

// MARK: - Default implementation
extension ErrorReasonExtractable {
	func errorReason(from error: Error) -> String? {
		if let localizedError = error as? LocalizedError {
			return localizedError.recoverySuggestion
		}
		return "Something bad happened. Please try again"
	}
}
