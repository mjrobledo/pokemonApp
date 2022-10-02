//
//
// Api.swift
// PokeApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 29/09/22.
// Copyright (c) 2022 and Confidential to MIGUEL ROBLEDO All rights reserved.
//


import Foundation


struct Constants {
    
    struct Url {
        static let apiURL = "https://pokeapi.co/"
        static let apiImage = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
    }
    
    struct ApiKeys {
        
    }
    
    static let limit = 20
    
    
    struct Images {
        static let allPokemon = "list.bullet"
        static let pokeball = "pokeball"
    }
    
    struct Colors {
        static let primary = "PrimaryColor"
    }
}

// MARK: - Llamadas a servicios

enum Api: String {
    
    case pokemonList = "api/v2/ability/"
    case pokemon = "api/v2/pokemon/%@/"
    case pokemonType = "api/v2/type/%@/"
    
    func apiURL(data: String? = nil) -> String {
        let apiURL = Constants.Url.apiURL
        
        switch self {
        case .pokemonList:
            var url = "\(apiURL)\(self.rawValue)"
            if let data = data {
                url = data
            }
            return url
        case .pokemon:
            return "\(apiURL)\(self.rawValue)".replacingOccurrences(of: "%@", with: data ?? "")
            
        case .pokemonType:
            return "\(apiURL)\(self.rawValue)".replacingOccurrences(of: "%@", with: data ?? "")
        }
    }
    
    var method: Method {
        switch self {
        case .pokemonList, .pokemonType:
            return .getMethod
        case .pokemon:
            return .getMethod
        }
    }
    
    enum Method: String {
        case postMethod = "POST"
        case getMethod = "GET"
        case putMethod = "PUT"
        case deleteMethod = "DELETE"
    }

}
