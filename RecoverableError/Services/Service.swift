//
//  Service.swift
//  Recoverable
//
//  Created by Aleksandr Lavrinenko on 13.01.2020.
//  Copyright © 2020 Aleksandr Lavrinenko. All rights reserved.
//

import Foundation

protocol ServiceInput: class {
	@discardableResult
	func requestObject(completionHandler: @escaping ((Result<Bool, Error>) -> Void)) -> Task

	@discardableResult
	func runOfSpace(completionHandler: @escaping ((Result<Bool, Error>) -> Void)) -> Task
}

final class Service { }

extension Service: ServiceInput {
	@discardableResult
	func requestObject(completionHandler: @escaping ((Result<Bool, Error>) -> Void)) -> Task {
		return Task {
			completionHandler(.failure(NetworkError.internetError))
		}
		.delayedTask(time: 0.3)
		.run()
	}

	@discardableResult
	func runOfSpace(completionHandler: @escaping ((Result<Bool, Error>) -> Void)) -> Task {
		return Task {
			completionHandler(.failure(NetworkError.internetError))
		}
		.delayedTask(time: 0.3)
		.run()
	}
}
