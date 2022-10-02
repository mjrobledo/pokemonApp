//
//
// PokemonList.swift
// PokeApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 29/09/22.
// Copyright (c) 2022 and Confidential to MIGUEL ROBLEDO All rights reserved.
//


import Foundation


protocol DefaultProtocol {
    var name: String? { get }
    var url: String? { get }
}

struct PokemonList : Codable {
    let count : Int?
    let next : String?
    let previous : String?
    let results : [Pokemon]?

    enum CodingKeys: String, CodingKey {

        case count = "count"
        case next = "next"
        case previous = "previous"
        case results = "results"
    }
}

struct Pokemon : DefaultProtocol,  Codable {
    var name: String?
    var url: String?
    
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case url = "url"
    }
    
    var idPokemon: Int? {
        guard let url = url else {
            return nil
        }
        
        guard let data = url.split(whereSeparator: {$0 == "/"}).map(String.init).last else {
            return nil
        }
        
        if let id = Int(data.replacingOccurrences(of: ".png", with: "")) {
            return id
        }
        return nil
    }
    
    var imageUrl: String? {
        
        if let id = self.idPokemon {
            return "\(Constants.Url.apiImage)\(id).png"
        }
        return nil
    }
}

