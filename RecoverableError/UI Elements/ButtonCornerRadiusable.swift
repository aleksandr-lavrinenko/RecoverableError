//
//  ButtonCornerRadiusable.swift
//  RecoverableError
//
//  Created by Aleksandr Lavrinenko on 16.02.2020.
//  Copyright © 2020 Aleksandr Lavrinenko. All rights reserved.
//

import UIKit

protocol ButtonCornerRadiusable {
	var cornerRadius: CGFloat { get }
	
	func addCorners(radius: CGFloat)
}

extension ButtonCornerRadiusable where Self: UIButton {
	func addCorners(radius: CGFloat) {
		let pathWithRadius = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
		let maskLayer = CAShapeLayer()
		maskLayer.path = pathWithRadius.cgPath
		maskLayer.frame = bounds
		layer.mask = maskLayer
	}
}
