//
//  DailyForecastCell.swift
//  WeatherApp
//
//  Created by Лилия Андреева on 19.05.2025.
//

import UIKit

class DailyForecastCell: UICollectionViewCell {
	static let reuseIdentifier = ConstantStrings.dailyForecastCellCellReuseIdentifier
	
	private lazy var dayLabel = makeConfiguredLabel(fontSize: Sizes.fontSizes.tiny, weight: .medium)
	private lazy var temperatureLabel = makeConfiguredLabel(fontSize: Sizes.fontSizes.tiny, weight: .medium)
	private lazy var conditionLabel = makeConfiguredLabel(fontSize: Sizes.fontSizes.tiny, weight: .regular)
	private lazy var windLabel = makeConfiguredLabel(fontSize: Sizes.fontSizes.tiny, weight: .regular)
	private lazy var humidityLabel = makeConfiguredLabel(fontSize: Sizes.fontSizes.tiny, weight: .regular)
	
	let weatherIconImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()


	private let stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.spacing = Sizes.Paddings.miniStackSpacing
		stackView.alignment = .center
		stackView.distribution = .fillProportionally
		return stackView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	

	
	func configure(with model: ForecastDisplayModel.DailyForecast) {
		dayLabel.text = "\(model.date)"
		temperatureLabel.text = model.temperature
		conditionLabel.text = model.conditionText
		windLabel.text =  model.windSpeed
		humidityLabel.text = model.humidity

	}
}

private extension DailyForecastCell {
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

			weatherIconImageView.heightAnchor.constraint(equalToConstant: Sizes.iconSize),
			weatherIconImageView.widthAnchor.constraint(equalToConstant: Sizes.iconSize)
		])
		[dayLabel, conditionLabel, temperatureLabel, windLabel, humidityLabel].forEach { label in
			label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
			label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
			label.adjustsFontSizeToFitWidth = true
			label.minimumScaleFactor = 0.7
		}
	}
	
	func makeConfiguredLabel(fontSize: CGFloat, weight: UIFont.Weight = .regular) -> UILabel {
		let label = UILabel()
		label.font = .systemFont(ofSize: fontSize, weight: weight)
		label.textColor = .white
		label.textAlignment = .left
		label.numberOfLines = 1
		label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
		label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
		return label
	}
}
