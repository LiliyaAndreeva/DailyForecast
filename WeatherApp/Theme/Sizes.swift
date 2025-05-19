//
//  Sizes.swift
//  WeatherApp
//
//  Created by Лилия Андреева on 16.05.2025.
//

import Foundation
enum Sizes {
	static let alpha: CGFloat = 0.5
	static let iconSize: CGFloat = 40
	static let cornerRadius: CGFloat = 15
	
	
	enum Paddings {
		static let sidePadding: CGFloat = 10
		static let miniStackSpacing: CGFloat = 4
		static let stackSpacing: CGFloat = 16
		static let lineSpacing: CGFloat = 12
		static let horizontalInset: CGFloat = 16
	}

	enum fontSizes {
		static let tiny: CGFloat = 14
		static let normal: CGFloat = 32
		static let double: CGFloat = 56
	}
	enum itemSizes {
		static let daylyConllectionItem: (CGFloat, CGFloat) = (40, 50)
	}
}

