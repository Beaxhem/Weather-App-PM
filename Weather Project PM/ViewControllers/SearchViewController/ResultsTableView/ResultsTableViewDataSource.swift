//
//  ResultsTableViewDataSource.swift
//  Weather Project PM
//
//  Created by Ilya Senchukov on 25.01.2021.
//

import UIKit

class ResultsTableViewDataSource: NSObject, UITableViewDataSource {
    var results: [OneCityQuery] = []
    
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
