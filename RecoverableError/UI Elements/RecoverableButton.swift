//
//  RecoverableButton.swift
//  RecoverableError
//
//  Created by Aleksandr Lavrinenko on 16.02.2020.
//  Copyright © 2020 Aleksandr Lavrinenko. All rights reserved.
//

import UIKit

final class RecoverableButton: TouchAppButton {
	override func draw(_ rect: CGRect) {
		super.draw(rect)

		addCorners(radius: cornerRadius)
	}
}

extension RecoverableButton: ButtonCornerRadiusable {
	var cornerRadius: CGFloat { return 8 }
}
