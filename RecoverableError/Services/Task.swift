//
//  Task.swift
//  Recoverable
//
//  Created by Aleksandr Lavrinenko on 09.02.2020.
//  Copyright © 2020 Aleksandr Lavrinenko. All rights reserved.
//

import Foundation

struct Task {
	let closure: () -> Void

	private var _delayTime: Double?

	init(closure: @escaping () -> Void) {
		self.closure = closure
	}

	fileprivate init(closure: @escaping () -> Void, time: Double) {
		self.closure = closure
		_delayTime = time
	}

	@discardableResult
	func run() -> Self {
		if let delayTime = _delayTime {
			DispatchQueue.global().asyncAfter(deadline: .now() + delayTime) {
				self.closure()
			}
			return self
		}
		closure()
		return self
	}

	func delayedTask(time: Double) -> Self {
		return Task(closure: closure, time: time)
	}
}
