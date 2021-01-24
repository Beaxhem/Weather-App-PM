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
    
    var searchTimer: Timer?
    
    var results: [OneCityQuery] = [] {
        didSet {
            self.resultsTableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        cityTextField?.addTarget(self, action: #selector(textFieldDidEditingChanged(_:)), for: .editingChanged)
        
        resultsTableView?.dataSource = self
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
        guard let query = timer.userInfo as? String, query != "" else { return }
        
        results = []
        
        WeatherManager.shared.loadCurrentWeather(byCityname: query) { [weak self] res in
            switch res {
            case .failure(let error):
                print(error)
            case .success(let request):
                print("Request")
                self?.results = [request]
            }
        }
    }
    
    @IBAction func done() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultsTableViewCell.id) as? ResultsTableViewCell else {
            fatalError()
        }
        
        let result = results[indexPath.item]
        cell.configure(with: result)
        
        return cell
    }
    
    
}
