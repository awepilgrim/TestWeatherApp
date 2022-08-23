//
//  WeatherTVC.swift
//  WheatherTestTask
//
//  Created by Олег Семёнов on 04.08.2022.
//

import UIKit

class WeatherTVC: UITableViewController {
    
    var emptyCity = Weather()
    var filteredCityArray = [Weather]()
    var citiesArray = [Weather]()
    var nameCitiesArray = ["Санкт-Петербург", "Москва", "Самара", "Тольятти", "Новосибирск", "Калининград", "Владивосток", "Екатеринбург", "Казань", "Уфа"]
    
    let searchContoller = UISearchController(searchResultsController: nil)
    
    var searchBarIsEmpty: Bool {
        guard let text = searchContoller.searchBar.text else { return false }
        return text.isEmpty
    }
    
    var isFiltering: Bool {
        return searchContoller.isActive && !searchBarIsEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if citiesArray.isEmpty {
            citiesArray = Array(repeating: emptyCity, count: nameCitiesArray.count)
        }
        addCitiesWeather()
        
        searchContoller.searchResultsUpdater = self
        searchContoller.obscuresBackgroundDuringPresentation = false
        searchContoller.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchContoller
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    @IBAction func addCityAction(_ sender: Any) {
        alertPlusCity(name: "Город", placeholder: "Введите название города") { city in
            self.nameCitiesArray.append(city)
            self.citiesArray.append(self.emptyCity)
            self.addCitiesWeather()
        }
    }
    
    func addCitiesWeather() {
     
        getCityWeather(citiesArray: self.nameCitiesArray) { [self] index, weather in
            citiesArray[index] = weather
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering { return filteredCityArray.count }
             
        return citiesArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListCell
        
        var weather = Weather()
        
        if isFiltering {
            weather = filteredCityArray[indexPath.row]
        } else {
            weather = citiesArray[indexPath.row]
        }
        cell.configure(weather: weather)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, completion in
            
            let editingRow = self.nameCitiesArray[indexPath.row]
            if let index = self.nameCitiesArray.firstIndex(of: editingRow) {
                
                if self.isFiltering {
                    self.filteredCityArray.remove(at: index)
                } else {
                    self.citiesArray.remove(at: index)
                }
            }
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            if isFiltering {
                
                let filteredCityWeather = filteredCityArray[indexPath.row]
                let dstVC = segue.destination as! DetailVC
                dstVC.weatherModel = filteredCityWeather
            } else {
                
                let cityWeather = citiesArray[indexPath.row]
                let dstVC = segue.destination as! DetailVC
                dstVC.weatherModel = cityWeather
            }
        }
    }
}

extension WeatherTVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filteredContentForSearchText(searchController.searchBar.text!)
    }
    private func filteredContentForSearchText(_ searchText: String) {
        
        filteredCityArray = citiesArray.filter {
            $0.cityName.contains(searchText)
        }
        tableView.reloadData()
    }
    
}
