//
//  ViewController.swift
//  OpenWeather
//
//  Created by yan feng on 2023/5/12.
//

import UIKit
import CoreLocation

class MainViewController: UITableViewController, ActivityPresentable {
    let identifier = "UITableViewCell"
    private let locationManager = CLLocationManager()
    private var viewModel = LocationViewModel()
    private var bookmarkedLocation = StoredLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        bindDataToUI()
        fetchStoredLocations()
    }
    
    private func fetchStoredLocations() {
        viewModel.fetchStoredLocations()
    }
    
    private func bindDataToUI() {
        viewModel.isLoading.bind { [unowned self] (isLoading) in
            if isLoading { self.presentActivity() }
            else { self.dismissActivity() }
        }
        
        viewModel.error.bind { [unowned self] (error) in
            self.presentSimpleAlert(title: "Incorrect Input or Input Format",
                                    message:  error?.description ?? "")
        }

        viewModel.storedLocations.bindAndFire { [unowned self] (locations) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: Set Up UI
    lazy var searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.placeholder = "Search City"
        return searchBar
    }()
}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.convertToGeoCoordinates(searchBar.text)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}


extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.storedLocations.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = viewModel.storedLocations.value[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = viewModel.storedLocations.value[indexPath.row]
        navigationController?.pushViewController(DetailViewController(location: location), animated: true)
    }
}

extension MainViewController: CLLocationManagerDelegate{

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        viewModel.saveCurrentLocation(lat: latitude, lon: longitude)
    }
}
