//
//  AboveAllAlertControler.swift
//  Recoverable
//
//  Created by Aleksandr Lavrinenko on 02.02.2020.
//  Copyright © 2020 Aleksandr Lavrinenko. All rights reserved.
//

import UIKit

final class AboveAllAlertController: UIAlertController {
	var alertWindow: UIWindow {
		return AppDelegate.alertWindow
	}

	func show() {
		let topWindow = UIApplication.shared.windows.last
		if let topWindow = topWindow {
			alertWindow.windowLevel = topWindow.windowLevel + 1
		}

		alertWindow.makeKeyAndVisible()
		alertWindow.rootViewController?.present(self, animated: true, completion: nil)
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)

		alertWindow.isHidden = true
	}
}
