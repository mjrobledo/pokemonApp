//
//
// PokemonModel.swift
// PokeApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 29/09/22.
// Copyright (c) 2022 and Confidential to MIGUEL ROBLEDO All rights reserved.
//


import Foundation



struct PokemonDetail : Codable {
    let base_experience : Int?
    let height : Int?
    
    let id : Int?
    let is_default : Bool?
    let location_area_encounters : String?
    
    let name : String?
    let order : Int?
    let sprites : Sprites?
    let stats : [Stats]?
    let types : [Types]?
    let weight : Int?

    enum CodingKeys: String, CodingKey {
        case base_experience = "base_experience"
        case height = "height"
        
        case id = "id"
        case is_default = "is_default"
        case location_area_encounters = "location_area_encounters"
        case name = "name"
        case order = "order"
        case sprites = "sprites"
        case stats = "stats"
        case types = "types"
        case weight = "weight"
    }
    


}



struct Sprites : Codable {
    let front_default : String?
    let front_shiny : String?
    
    enum CodingKeys: String, CodingKey {

        case front_default = "front_default"
        case front_shiny = "front_shiny"
    }
}


struct Stats : Codable {
    let base_stat : Int?
    let effort : Int?
    let stat : Stat?

    enum CodingKeys: String, CodingKey {

        case base_stat = "base_stat"
        case effort = "effort"
        case stat = "stat"
    }
}


struct Stat : Codable {
    let name : String?
    let url : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }

}


struct Types : Codable {
    let slot : Int?
    let type : PokemonType?

    enum CodingKeys: String, CodingKey {

        case slot = "slot"
        case type = "type"
    }
}


struct PokemonType : Codable {
    let name : String?
    let url : String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case url = "url"
    }
}
