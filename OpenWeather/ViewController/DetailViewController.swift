//
//  DetailViewController.swift
//  OpenWeather
//
//  Created by yan feng on 2023/5/12.
//

import UIKit
import CoreLocation

class DetailViewController: UIViewController, ActivityPresentable  {
    
    private var viewModel = WeatherViewModel()
    
    convenience init(location: Location) {
        self.init()
        viewModel = WeatherViewModel(location: location)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setUpUI()
        fetchWeather()
        bindDataToUI()
    }
    
    private func fetchWeather() {
        viewModel.fetchWeather()
    }

    private func bindDataToUI() {
        viewModel.isLoading.bind { [unowned self] (isLoading) in
            if isLoading { self.presentActivity() }
            else { self.dismissActivity() }
        }
        
        viewModel.error.bind { [unowned self] (error) in
            self.presentSimpleAlert(title: "Open Weather",
                                    message: error?.description ?? "")
        }
        
        viewModel.weatherFormatted.bind { [unowned self] (weather) in
            if let weather = weather {
                DispatchQueue.main.async {
                    self.setupData(weather)
                }
            }
        }
    }
    
    private func setupData(_ weather: WeatherFormatted) {
        titleLabel.text = weather.locationName
        temparatureLabel.text = weather.temparature
        weatherConditionLabel.text = weather.condition
        weatherDescriptionlabel.text = weather.description
        weatherImageView.image = UIImage(named: "icon-\(weather.image)")
        feelsLikeLabel.text = weather.feelsLike
        maxMinTemparatureLabel.text = weather.minMaxTemparature
        rainPercentageLabel.text = weather.rainPercent
        windDirectionLabel.text = weather.windDirection
    }
    
    private func setUpUI() {
        view.addSubview(VStackView)
        VStackView.addArrangedSubview(titleLabel)
        VStackView.addArrangedSubview(bodyVStackView)
        VStackView.addArrangedSubview(bottomView)
        bodyVStackView.addArrangedSubview(firstSectionHStackView)
        firstSectionHStackView.addArrangedSubview(firstSectionVStackView)
        firstSectionHStackView.addArrangedSubview(weatherImageView)
        firstSectionVStackView.addArrangedSubview(temparatureLabel)
        firstSectionVStackView.addArrangedSubview(weatherConditionLabel)

        bodyVStackView.addArrangedSubview(secondSectionHStackView)
        bodyVStackView.addArrangedSubview(weatherDescriptionlabel)
        secondSectionHStackView.addArrangedSubview(secondSectionLeftVStackView)
        secondSectionHStackView.addArrangedSubview(secondSectionRightVStackView)
        
        secondSectionLeftVStackView.addArrangedSubview(feelsLikeLabel)
        secondSectionLeftVStackView.addArrangedSubview(maxMinTemparatureLabel)
        
        secondSectionRightVStackView.addArrangedSubview(rainHStackView)
        secondSectionRightVStackView.addArrangedSubview(windHStackView)
        
        rainHStackView.addArrangedSubview(rainImageView)
        rainHStackView.addArrangedSubview(rainPercentageLabel)
        windHStackView.addArrangedSubview(windImageView)
        windHStackView.addArrangedSubview(windDirectionLabel)
        
        NSLayoutConstraint.activate([
            VStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            VStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            VStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            VStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    //MARK: Set up UI
    lazy var VStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 40
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 40)
        return label
    }()
    
    lazy var bodyVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var firstSectionHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var firstSectionVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var temparatureLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 40)
        return label
    }()
    
    lazy var weatherConditionLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    lazy var weatherImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.5).isActive = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var secondSectionHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    lazy var secondSectionLeftVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var feelsLikeLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    lazy var maxMinTemparatureLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    lazy var weatherDescriptionlabel: UILabel = {
       let label = UILabel()
        return label
    }()

    lazy var secondSectionRightVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var rainHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    lazy var rainPercentageLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    lazy var rainImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon-rain"))
        imageView.contentMode = .scaleAspectFit
         return imageView
    }()
    
    lazy var windHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    lazy var windDirectionLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    lazy var windImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon-wind"))
        imageView.contentMode = .scaleAspectFit
         return imageView
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView()
         return view
    }()
}


