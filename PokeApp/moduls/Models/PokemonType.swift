//
//
// PokemonType.swift
// PokeApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 01/10/22.
// Copyright (c) 2022 and Confidential to MIGUEL ROBLEDO All rights reserved.
//


import Foundation


struct PokemonTypeResponse : Codable {
    let id : Int?
    let name: String?
    
    let pokemons : [PokemonSearchType]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case pokemons = "pokemon"
    }
}

struct PokemonSearchType : Codable {
    
    let pokemon : Pokemon?

    enum CodingKeys: String, CodingKey {
        case pokemon = "pokemon"
    }
}

