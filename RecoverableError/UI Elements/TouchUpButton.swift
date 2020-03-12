//
//  TouchUpButton.swift
//  Recoverable
//
//  Created by Aleksandr Lavrinenko on 02.02.2020.
//  Copyright © 2020 Aleksandr Lavrinenko. All rights reserved.
//

import UIKit

class TouchAppButton: UIButton {
	var touchUpInsideBlock: (() -> Void)?

	convenience init(touchUpInsideBlock: (() -> Void)?) {
		self.init(type: .system)

		self.touchUpInsideBlock = touchUpInsideBlock
	}
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:)")
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		_setupButton()
	}

	override var intrinsicContentSize: CGSize {
		return CGSize(width: UIScreen.main.bounds.width, height: 48)
	}

	private func _setupButton() {
		addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
	}

	@objc func touchUpInside() {
		touchUpInsideBlock?()
	}
}
