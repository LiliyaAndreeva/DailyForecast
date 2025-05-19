//
//  SelfSizingCollectionView.swift
//  WeatherApp
//
//  Created by Лилия Андреева on 19.05.2025.
//

import UIKit
final class SelfSizingCollectionView: UICollectionView {
	override var contentSize: CGSize {
		didSet {
			invalidateIntrinsicContentSize()
		}
	}

	override var intrinsicContentSize: CGSize {
		return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
	}
}
