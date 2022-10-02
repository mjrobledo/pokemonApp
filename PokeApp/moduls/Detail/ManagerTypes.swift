//
//
// ManagerTypes.swift
// PokeApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 30/09/22.
// Copyright (c) 2022 and Confidential to MIGUEL ROBLEDO All rights reserved.
//


import Foundation
import UIKit

class ManagerTypes : UIViewController, UICollectionViewDataSource {
    private var data: [Types] = []
    var selectedIndex = { (type: String)  in }
     
    
    func setData(data: [Types]) {
        self.data = data
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CellType else {
            return UICollectionViewCell()
        }
        
        if let typeP = data[indexPath.row].type {
            cell.loadCell(pokemonType: typeP)
        }
        
        return cell
    }
}


extension ManagerTypes: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let name = data[indexPath.row].type?.name else {
            return
        }
        
        selectedIndex(name)
    }
}
                            
extension ManagerTypes: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width - 15) / 4) 
        
        return CGSize(width: width, height: collectionView.frame.height)
    }
}
