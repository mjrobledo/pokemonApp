//
//
// CellType.swift
// PokeApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 30/09/22.
// Copyright (c) 2022 and Confidential to MIGUEL ROBLEDO All rights reserved.
//


import UIKit

class CellType: UICollectionViewCell {

    @IBOutlet private weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func loadCell(pokemonType: PokemonType) {
        lblName.text = pokemonType.name
        self.backgroundColor = UIColor.random()
    }
}
