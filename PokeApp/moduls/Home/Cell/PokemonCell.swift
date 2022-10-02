//
//
// PokemonCell.swift
// PokeApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 29/09/22.
// Copyright (c) 2022 and Confidential to MIGUEL ROBLEDO All rights reserved.
//


import UIKit

class PokemonCell: UICollectionViewCell {

    @IBOutlet private weak var lblName: UILabel!
    @IBOutlet private weak var imgPokemon: UIImageView!
    
    var pokemon: Pokemon? {
        didSet {
            lblName.text = pokemon?.name
            
            if let imageUrl = pokemon?.imageUrl {
                imgPokemon.imageFromServerUrl(urlString: imageUrl,
                                              placeholder: UIImage(named: Constants.Images.pokeball) ?? UIImage())
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
