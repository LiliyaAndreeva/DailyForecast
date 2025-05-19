//
//  ApiEndpoint.swift
//  WeatherApp
//
//  Created by Лилия Андреева on 16.05.2025.
//

import Foundation

enum APIEndpoint {
	case forecast

	var url: URL {
		let key = "680bedb005bd443cb46154008251605"
		return URL(string: "https://api.weatherapi.com/v1/forecast.json?key=\(key)&q=tyumen&days=5&lang=ru")!
	}
}
