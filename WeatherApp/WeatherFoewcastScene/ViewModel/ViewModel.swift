//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Лилия Андреева on 16.05.2025.
//

import UIKit
protocol WeatherForecastViewModelProtocol: AnyObject {
	var onDataUpdate: ((ForecastDisplayModel) -> Void)? { get set }
	var onError: ((Error) -> Void)? { get set }
	func loadWeather()
}

final class WeatherForecastViewModel: WeatherForecastViewModelProtocol {
	private let networkManager: NetworkManagerProtocol
	var onDataUpdate: ((ForecastDisplayModel) -> Void)?
	var onError: ((Error) -> Void)?
	
	init(networkManager: NetworkManagerProtocol) {
		self.networkManager = networkManager
	}
	
	func loadWeather() {
		networkManager.fetchData(url: APIEndpoint.forecast.url) { [weak self] (result: Result<ForecastWeatherResponse, Error>) in
			switch result {
			case .success(let responce):
				let displayModel = self?.mapToDisplayModel(from: responce)
				if let displayModel = displayModel {
					self?.onDataUpdate?(displayModel)
				}
			case .failure(let error):
				self?.onError?(error)
			}
		}
	}
}

private extension WeatherForecastViewModel {
	func mapToDisplayModel(from response: ForecastWeatherResponse) -> ForecastDisplayModel {
		let dailyForecasts = response.forecast.forecastday.map { forecastDay in
			ForecastDisplayModel.DailyForecast(
				date: formatDate(forecastDay.date),
				temperature: String(format: "%.1f°C", forecastDay.day.avgtempC),
				windSpeed: String(format: "%.1f км/ч", forecastDay.day.maxwindKph),
				humidity: String(format: "%d%%", Int(forecastDay.day.avghumidity)),
				conditionText: forecastDay.day.condition.text,
				conditionIconURL: buildIconURL(from: forecastDay.day.condition.icon)
			)
		}
		
		return ForecastDisplayModel(
			cityName: response.location.name,
			dailyForecasts: dailyForecasts
		)
	}
	
	func formatDate(_ dateString: String) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		if let date = formatter.date(from: dateString) {
			formatter.dateFormat = "d MMMM"
			formatter.locale = Locale(identifier: "ru_RU")
			return formatter.string(from: date)
		}
		return dateString
	}
	func buildIconURL(from path: String) -> URL? {
		return URL(string: "https:\(path.trimmingCharacters(in: .whitespaces))")
	}

}

