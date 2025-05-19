//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by Лилия Андреева on 16.05.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?


	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let scene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: scene)
		let weatherViewComtroller = makeRootViewController()
		window.rootViewController = weatherViewComtroller
		window.makeKeyAndVisible()

		self.window = window
	}

}

private func makeRootViewController() -> UIViewController {
	let networkManager = NetworkManager.shared
	let viewModel = WeatherForecastViewModel(networkManager: networkManager)
	let viewController = WeatherViewController(viewModel: viewModel)
	return viewController
}
