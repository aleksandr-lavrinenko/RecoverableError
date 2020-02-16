//
//  RecoveryOptions.swift
//  RecoverableError
//
//  Created by Aleksandr Lavrinenko on 15.02.2020.
//  Copyright © 2020 Aleksandr Lavrinenko. All rights reserved.
//

import Foundation

enum RecoveryOptions {
	case tryAgain(action: (() -> Void))
	case freeSpace(action: (() -> Void))
	case buyMoreSpace(action:  (() -> Void))
	case custom(title: String, action: (() -> Void))
	case cancel

	var title: String {
		switch self {
		case .tryAgain:
			return "Try again"
		case .freeSpace:
			return "Free space"
		case .buyMoreSpace:
			return "Buy more space"
		case .custom(let title, _):
			return title
		case .cancel:
			return "Cancel"
		}
	}
}
