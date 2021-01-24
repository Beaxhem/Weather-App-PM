//
//  IDsProvider.swift
//  Weather Project PM
//
//  Created by Ilya Senchukov on 25.01.2021.
//

import Foundation

protocol IdsProvider{
    func getIDs() -> [String]
    func addID(id: String)
}

class CitiesIdsProvider {
    private let key = "citiesIDs"
    private let provider = UserDefaults.standard
    
    func getIDs() -> [String] {
        return provider.stringArray(forKey: key) ?? []
    }
    
    func addID(id: String) {
        var citiesIDs = getIDs()
        citiesIDs.append(id)
        
        provider.set(citiesIDs, forKey: key)
    }
}

