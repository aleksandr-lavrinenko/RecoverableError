//
//  ErrorViewRemovable.swift
//  RecoverableError
//
//  Created by Aleksandr Lavrinenko on 15.02.2020.
//  Copyright © 2020 Aleksandr Lavrinenko. All rights reserved.
//

import UIKit

protocol ErrorViewRemovable {
	var errorViewSuperview: UIView { get }

	func removeErrorView()
}

// MARK: - DefaultImplementation
extension ErrorViewRemovable {
	func removeErrorView() {
		errorViewSuperview.subviews
			.filter({ $0 is ErrorView })
			.forEach({ $0.removeFromSuperview() })
	}
}
