//
//  Model.swift
//  WeatherApp
//
//  Created by Лилия Андреева on 16.05.2025.
//

import Foundation
struct ForecastWeatherResponse: Codable {
	let location: Location
	let forecast: Forecast
}
struct Location: Codable {
	let name: String
}

struct Forecast: Codable {
	let forecastday: [ForecastDay]
}

struct ForecastDay: Codable {
	let date: String
	let day: Day
}

struct Day: Codable {

	let avgtempC: Double
	let maxwindKph: Double
	let avghumidity: Double
	let condition: Condition

	enum CodingKeys: String, CodingKey {
		case avgtempC = "avgtemp_c"
		case maxwindKph = "maxwind_kph"
		case avghumidity
		case condition
	}
}

struct Condition: Codable {
	let text: String
	let icon: String
	let code: Int
}
