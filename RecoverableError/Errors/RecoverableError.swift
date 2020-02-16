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

//class RetryableNSError: NSError {
//
//}
//
//extension RetryableNSError: RecoverableError {
//	func attemptRecovery(optionIndex recoveryOptionIndex: Int) -> Bool {
//		return true
//	}
//
//	var recoveryOptions: [String] {
//		return ["Try"]
//	}
//
//	func attemptRecovery(optionIndex: Int, resultHandler: (Bool) -> Void) {
//		switch optionIndex {
//		case 0:
//			resultHandler(true)
//		default:
//			resultHandler(false)
//			break
//		}
//	}
//}
//
//
//public extension Error {
//	/// Return an NSError with the same properties as this error but with an `UnanticipatedErrorRecoveryAttempter` attached.
//	func withUnanticipatedErrorRecoveryAttempter(file: String = #file, line: Int = #line) -> NSError {
//		let e = self as NSError
//		var userInfo: [String: Any] = e.userInfo
//
//		// Attach a new NSLocalizedRecoverySuggestionErrorKey and our recovery attempter and options
//		userInfo[NSLocalizedDescriptionKey] = self.localizedDescription
//		userInfo[NSLocalizedRecoverySuggestionErrorKey] = (self as? LocalizedError)?.errorDescription
//		userInfo[NSLocalizedRecoveryOptionsErrorKey] = UnanticipatedErrorRecoveryAttempter.localizedRecoveryOptions()
//		userInfo[NSRecoveryAttempterErrorKey] = UnanticipatedErrorRecoveryAttempter()
//
//
//		return NSError(domain: e.domain, code: e.code, userInfo: userInfo)
//	}
//}
//
//// A function that returns an `Error` of a non-public type, that already has `withUnanticipatedErrorRecoveryAttempter`
//public func undeclaredError(file: String = #file, line: Int = #line) -> Error {
//	struct UndeclaredError: LocalizedError {
//		var errorDescription: String? { return NSLocalizedString("An unspecified error occurred.", comment: "") }
//	}
//	return UndeclaredError().withUnanticipatedErrorRecoveryAttempter(file: file, line: line )
//}
//
///// A convenience wrapper that applies `withUnanticipatedErrorRecoveryAttempter` to any error thrown by the wrapped function
//public func rethrowUnanticipated<T>(file: String = #file, line: Int = #line, execute: () throws -> T) throws -> T {
//	do {
//		return try execute()
//	} catch {
//		throw error.withUnanticipatedErrorRecoveryAttempter(file: file, line: line)
//	}
//}
//
///// Class usable as the NSRecoveryAttempterErrorKey object in an NSError that presents the 'Unexpected' error and gives the option of copying the full error to the pasteboard.
//public class UnanticipatedErrorRecoveryAttempter: NSObject {
//	/// Present two buttons: "Copy details" and "OK"
//	fileprivate class func localizedRecoveryOptions() -> [String] {
//		return [NSLocalizedString("OK", comment:""), NSLocalizedString("Copy details", comment:"")]
//	}
//
//	/// There are two possible `attemptRecoveryFromError` methods. This one just feeds into the other.
//	public override func attemptRecovery(fromError error: Error, optionIndex: Int, delegate: Any?, didRecoverSelector: Selector?, contextInfo: UnsafeMutableRawPointer?) -> Void {
//		_ = self.attemptRecovery(fromError: error, optionIndex: optionIndex)
//	}
//
//	/// When a button is tapped, either close the dialog or copy the error details as appropriate.
//	public override func attemptRecovery(fromError error: Error, optionIndex: Int) -> Bool {
//		// The "Copy details" button is index 1 in the buttons array.
//		let copyDetailsButtonIndex = 1
//
//		switch optionIndex {
//		case copyDetailsButtonIndex:
//			return true
//		default:
//			return false;
//		}
//	}
//}
//
//#if os(iOS)
//
///// A protocol to provide functionality similar to NSResponder.presentError on Mac OS X.
//public protocol ErrorPresenter {
//	func presentError(_ error: NSError, _ completion: (() -> Void)?)
//}
//
//// Implement the ErrorPresent on UIViewController rather than UIResponder since presenting a `UIAlertController` requires a parent `UIViewController`
//extension UIViewController: ErrorPresenter {
//	/// An adapter function that allows the UnanticipatedErrorRecoveryAttempter to be used on iOS to present errors over a UIViewController.
//	public func presentError(_ error: NSError, _ completion: (() -> Void)? = nil) {
//		let alert = UIAlertController(title: error.localizedDescription, message: error.localizedRecoverySuggestion ?? error.localizedFailureReason, preferredStyle: UIAlertController.Style.alert)
//
//		if let ro = error.localizedRecoveryOptions, let ra = error.recoveryAttempter as? UnanticipatedErrorRecoveryAttempter {
//			for (index, option) in ro.enumerated() {
//				alert.addAction(UIAlertAction(title: option, style: UIAlertAction.Style.default, handler: { (action: UIAlertAction?) -> Void in
//					_ = ra.attemptRecovery(fromError: error, optionIndex: index)
//				}))
//			}
//		}
//		self.present(alert, animated: true, completion: completion)
//	}
//}
//
//#endif
