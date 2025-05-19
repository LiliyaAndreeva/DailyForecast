//
//  DailyForecastCell.swift
//  WeatherApp
//
//  Created by Лилия Андреева on 19.05.2025.
//

import UIKit

class DailyForecastCell: UICollectionViewCell {
	static let reuseIdentifier = ConstantStrings.dailyForecastCellCellReuseIdentifier
	
	private let dayLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: Sizes.fontSizes.tiny, weight: .medium)
		label.textColor = .white
		label.textAlignment = .left
		return label
	}()
	
	let weatherIconImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	private let temperatureLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: Sizes.fontSizes.tiny, weight: .regular)
		label.textColor = .white
		label.textAlignment = .center
		return label
	}()
	
	private let conditionLabel: UILabel = {
		let label = UILabel()
		label.textColor = .white
		label.font = .systemFont(ofSize:  Sizes.fontSizes.tiny, weight: .regular)
		label.numberOfLines = 1
		return label
	}()
	
	private let windLabel: UILabel = {
		let label = UILabel()
		label.textColor = .white
		label.font = .systemFont(ofSize:  Sizes.fontSizes.tiny, weight: .regular)
		return label
	}()

	private let humidityLabel: UILabel = {
		let label = UILabel()
		label.textColor = .white
		label.font = .systemFont(ofSize: Sizes.fontSizes.tiny, weight: .regular)
		return label
	}()
	
	private let stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.spacing = Sizes.Paddings.miniStackSpacing
		stackView.alignment = .center
		stackView.distribution = .fill
		return stackView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupUI() {
		contentView.addSubview(stackView)

		stackView.addArrangedSubview(dayLabel)
		stackView.addArrangedSubview(weatherIconImageView)
		stackView.addArrangedSubview(conditionLabel)
		stackView.addArrangedSubview(temperatureLabel)
		stackView.addArrangedSubview(windLabel)
		stackView.addArrangedSubview(humidityLabel)
		
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
			stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
		])
		
		weatherIconImageView.heightAnchor.constraint(equalToConstant: Sizes.iconSize).isActive = true
		weatherIconImageView.widthAnchor.constraint(equalToConstant: Sizes.iconSize).isActive = true
	}
	
	func configure(with model: ForecastDisplayModel.DailyForecast) {
		dayLabel.text = "\(model.date)"
		temperatureLabel.text = model.temperature
		conditionLabel.text = model.conditionText
		windLabel.text = "Ветер: \(model.windSpeed)"
		humidityLabel.text = "Влажность: \(model.humidity)"

	}
}
