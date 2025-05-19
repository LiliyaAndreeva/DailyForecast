//
//  ForecastDisplayModel.swift
//  WeatherApp
//
//  Created by Лилия Андреева on 19.05.2025.
//

import Foundation


struct ForecastDisplayModel {
	let cityName: String
	let dailyForecasts: [DailyForecast]
	
	struct DailyForecast {
		let date: String
		let temperature: String
		let windSpeed: String
		let humidity: String
		let conditionText: String
		let conditionIconURL: URL?
	}
	
}
