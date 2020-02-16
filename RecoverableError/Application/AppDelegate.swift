//
//  AppDelegate.swift
//  Recoverable
//
//  Created by Aleksandr Lavrinenko on 13.01.2020.
//  Copyright © 2020 Aleksandr Lavrinenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	
	// Static переменная будет ленивой
	static private(set) var alertWindow: UIWindow = {
		let alertWindow = UIWindow.init(frame: UIScreen.main.bounds)
		alertWindow.backgroundColor = .clear

		// Создадим rootViewController, который будет делать present для новый viewController
		let viewController = UIViewController()
		viewController.view.backgroundColor = .clear
		alertWindow.rootViewController = viewController

		return alertWindow
	}()

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		return true
	}
}

