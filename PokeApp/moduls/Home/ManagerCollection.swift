//
//
// ManagerCollection.swift
// PokeApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 02/10/22.
// Copyright (c) 2022 and Confidential to MIGUEL ROBLEDO All rights reserved.
//


import Foundation
import UIKit


class ManagerPokemonColl: UIViewController,  UICollectionViewDelegate {
    
    private var data: [Pokemon] = []
    var selectedPokemon = { (idPokemon: Int )  in }
   
    
    func setData (data: [Pokemon]) {
        self.data = data
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PokemonCell
        
        let pokemon  = data[indexPath.row]
        cell.pokemon = pokemon
        
        
        return cell
    }
    
}

extension ManagerPokemonColl: UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let idPokemon = data[indexPath.row].idPokemon else {
            return
        }
        
        selectedPokemon(idPokemon)
    }
}

extension ManagerPokemonColl: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width - 27) / 3)
        
        return CGSize(width: width, height: width + 20)
    }
}
