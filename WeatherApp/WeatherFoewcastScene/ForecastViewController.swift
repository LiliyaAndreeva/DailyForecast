//
//  ViewController.swift
//  WeatherApp
//
//  Created by Лилия Андреева on 16.05.2025.
//

import UIKit
import Kingfisher

class WeatherViewController: UIViewController {
	// MARK: - Dependencies
	private let viewModel: WeatherForecastViewModelProtocol
	private var displayModel: ForecastDisplayModel?
	// MARK: - Private properties
	var weatherView = WeatherForecastView()
	
	// MARK: - Initialization
	init(viewModel: WeatherForecastViewModelProtocol) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	// MARK: - Lifecycle
	override func loadView() {
		view = weatherView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViewModel()
		viewModel.loadWeather()
		weatherView.activityIndicator.startAnimating()
		setupVerticalCollectionView()
	}
}

// MARK: - Private extension
private extension WeatherViewController {
	func setupVerticalCollectionView() {
		weatherView.dailyCollectionView.dataSource = self
		weatherView.dailyCollectionView.register(
			DailyForecastCell.self,
			forCellWithReuseIdentifier: DailyForecastCell.reuseIdentifier
		)
	}
	func setupViewModel() {
		viewModel.onDataUpdate = { [weak self] displayModel in
			DispatchQueue.main.async {
				self?.displayModel = displayModel
				self?.update(with: displayModel)
				self?.weatherView.dailyCollectionView.reloadData()
			}
		}
		
		viewModel.onError = { [weak self] error in
			DispatchQueue.main.async {
				self?.showRetryAlert(message: error.localizedDescription) {
					self?.weatherView.activityIndicator.startAnimating()
					self?.viewModel.loadWeather()
				}
			}
		}
	}

	func update(with model: ForecastDisplayModel) {
		weatherView.cityNameLabel.text = model.cityName
		weatherView.dailyCollectionView.isHidden = false
		weatherView.activityIndicator.stopAnimating()
	}
	func showRetryAlert(message: String, retryAction: @escaping () -> Void) {
		let alert = UIAlertController(
			title: ConstantStrings.error,
			message: message,
			preferredStyle: .alert
		)

		alert.addAction(UIAlertAction(title: ConstantStrings.cancel, style: .cancel))
		alert.addAction(UIAlertAction(title: ConstantStrings.retry, style: .default) { _ in
			retryAction()
		})

		present(alert, animated: true)
	}
}

// MARK: - UICollectionViewDataSource
extension WeatherViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return displayModel?.dailyForecasts.count ?? 0
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: DailyForecastCell.reuseIdentifier,
			for: indexPath
		) as! DailyForecastCell
		
		if let forecast = displayModel?.dailyForecasts[indexPath.item] {
			cell.configure(with: forecast)
			if let url = forecast.conditionIconURL {
				cell.weatherIconImageView.kf.setImage(with: url)
			}
		}
		return cell
	}

}
