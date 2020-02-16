//
//  ErrorViewAddable.swift
//  Recoverable
//
//  Created by Aleksandr Lavrinenko on 02.02.2020.
//  Copyright © 2020 Aleksandr Lavrinenko. All rights reserved.
//

import UIKit

protocol ErrorViewAddable: class, ErrorViewRemovable {
	func presentErrorView(from error: Error)

	var errorViewSuperview: UIView { get }
}

// MARK: - Default implementation
extension ErrorViewAddable where Self: ErrorViewCreatable {
	func presentErrorView(from error: Error) {
		removeErrorView()
		
		let errorView = createErrorView(for: error)
		errorViewSuperview.addSubview(errorView)
		errorView.center = errorViewSuperview.center
	}
}
