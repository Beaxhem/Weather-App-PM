//
//  SearchViewController.swift
//  Weather Project PM
//
//  Created by Ilya Senchukov on 24.01.2021.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var resultsTableView: UITableView?
    @IBOutlet weak var cityTextField: UITextField?
    
    var delegate: SearchViewControllerDelegate?
    var searchTimer: Timer?
    let resultsDataSource = ResultsTableViewDataSource()
    
    override func viewDidLoad() {
        cityTextField?.addTarget(self, action: #selector(textFieldDidEditingChanged(_:)), for: .editingChanged)
        
        resultsTableView?.dataSource = resultsDataSource
        resultsTableView?.delegate = self
        resultsTableView?.register(UINib(nibName: ResultsTableViewCell.id, bundle: nil), forCellReuseIdentifier: ResultsTableViewCell.id)
    }
    
    @objc private func textFieldDidEditingChanged(_ textField: UITextField) {
        if searchTimer != nil {
            searchTimer?.invalidate()
            searchTimer = nil
        }
        
        searchTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(searchForKeyword(_:)), userInfo: textField.text!, repeats: false)
    }
    
    @objc private func searchForKeyword(_ timer: Timer) {
        guard var query = timer.userInfo as? String, query != "" else { return }
        
        query = query.trimmingCharacters(in: .whitespacesAndNewlines)
        resultsDataSource.results = []
        
        WeatherManager.shared.loadCurrentWeather(byCityname: query) { [weak self] res in
            switch res {
            case .failure(let error):
                print(error)
            case .success(let request):
                self?.resultsDataSource.results = [request]
                self?.resultsTableView?.reloadData()
            }
        }
    }
}

// Exit functionality
extension SearchViewController {
    @IBAction func done() {
        delegate?.onExit()
        
        self.dismiss(animated: true)
    }
}

// MARK: -UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result = resultsDataSource.results[indexPath.item]
        
        DatabaseManager.shared.addCityToFavourites(cityID: "\(result.id)") { [weak self] in
            self?.done()
        }
        
    }
}
