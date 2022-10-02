//
//
// DetailPokemonPresenter.swift
// PokeApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 29/09/22.
// Copyright (c) 2022 and Confidential to MIGUEL ROBLEDO All rights reserved.
//


import Foundation

protocol DetailProtocol : AnyObject {
    func hideLoader()
    func showLoader()
    func showError(_ message: String)
     
    func reloadData()
    
}

protocol DetailPresenterProtocol {
    var pokemon: PokemonDetail? { get set }
    var idPokemon: Int { get set }
    var pokemonTypeDelegate: PokemonTypeDelegate? { get set }
    
    var urlDetail: String { get set }
    func getPokemon()
    func selectedPokemon(name: String)
}

protocol PokemonTypeDelegate {
    func pokemonTypeSelected(name: String)
}


class DetailPresenter: DetailPresenterProtocol {
    var idPokemon: Int = 0
    
    var pokemon: PokemonDetail?
    var urlDetail: String = ""
    
    private weak var delegate: DetailProtocol?
    
    var pokemonTypeDelegate: PokemonTypeDelegate?
    
    
    init(delegate: DetailProtocol) {
        self.delegate = delegate
    }
    
    func getPokemon() {
        
        guard let delegate = delegate else {
            return
        }

        delegate.showLoader()
        APIClient().dataRequest(with: .pokemon, getParams: idPokemon.description, objectType: PokemonDetail.self) { response in
            delegate.hideLoader()
            
            switch response {
            case .success(let data):
                print(data)
                self.pokemon = data
                DispatchQueue.main.async {
                    self.delegate?.reloadData()
                }
                
            case .failure(let error):
                delegate.showError(error.localizedDescription)
            }
        }
    }

    func selectedPokemon(name: String) {
        guard let pokemonTypeDelegate = pokemonTypeDelegate else {
            return
        }

        pokemonTypeDelegate.pokemonTypeSelected(name: name)
    }
}
