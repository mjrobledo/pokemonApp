//
//
// HomeRouter.swift
// PokeApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 28/09/22.
// Copyright (c) 2022 and Confidential to MIGUEL ROBLEDO All rights reserved.
//


import Foundation
import UIKit


class NavigationApp {
    
    class func createHomeView() -> UIViewController {
        let bundle = Bundle(for: HomeView.self)
        let view = HomeView(nibName: "HomeView", bundle: bundle)
        view.title = .titleHome
        
        return view
        
    }
    
}

class DetailRouter {
    class func createView(idPokemon: Int, delegate: PokemonTypeDelegate) -> UIViewController {
        let bundle = Bundle(for: HomeView.self)
        
        let view = DetailPokemonlView(nibName: "DetailPokemonlView", bundle: bundle)
        view.presenter.pokemonTypeDelegate = delegate
        view.presenter.idPokemon = idPokemon
        
        return view
        
    }
    
}
