//
//  NetworkError.swift
//  Recoverable
//
//  Created by Aleksandr Lavrinenko on 13.01.2020.
//  Copyright © 2020 Aleksandr Lavrinenko. All rights reserved.
//

import Foundation

enum NetworkError {
	// Любой 500 код
	case serverError
	// Ответ не такой, как мы ожидаем
	case responseError
	// Ответа нет, отвалились по таймауту, отсуствует сеть
	case internetError

	// Ошибка от сервера, когда пользователю не хватает места в хранилище
	case runOfSpace
}

// MARK: - LocalizedError
extension NetworkError: LocalizedError {
	var errorDescription: String? {
		switch self {
		case .serverError, .responseError:
			return "Something bad happened"
		case .internetError:
			return "No internet connection"
		case .runOfSpace:
			return "Run out of space"
		}
	}

	var recoverySuggestion: String? {
		switch self {
		case .serverError, .responseError:
			return nil
		case .internetError:
			return "Please check your internet connection"
		case .runOfSpace:
			return "Please "
		}
	}
}
