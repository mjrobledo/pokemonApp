//
//
// DetaiPokemonlView.swift
// PokeApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 29/09/22.
// Copyright (c) 2022 and Confidential to MIGUEL ROBLEDO All rights reserved.
//


import UIKit

class DetailPokemonlView: UIViewController {

    @IBOutlet private weak var imgFronNormal: UIImageView!
    @IBOutlet private weak var imgFronShinyl: UIImageView!
    
    @IBOutlet private weak var lblNum: UILabel!
    @IBOutlet private weak var lblName: UILabel!
    
    @IBOutlet private weak var collTypes: UICollectionView!
    @IBOutlet private weak var tblStats: UITableView!
    
    lazy var presenter: DetailPresenterProtocol = DetailPresenter(delegate: self)
    
    private var managerTypes = ManagerTypes()
    private var managerStats = ManagerStats()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerCells()
        self.initialView()
        
        DispatchQueue.main.async {
            self.presenter.getPokemon()
        }
    }
    
    
    private func registerCells() {
        collTypes.register(UINib(nibName: "CellType", bundle: nil), forCellWithReuseIdentifier: "cell")
        tblStats.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

    }
    
    
    private func initialView() {
        collTypes.dataSource = managerTypes
        collTypes.delegate = managerTypes
        
        tblStats.dataSource = managerStats
        tblStats.delegate = managerStats
    }
    
    
    private func errorAlert(message: String) {
        let alert = UIAlertController(title: .titleSomethingWentWrong, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: .Continue, style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}


extension DetailPokemonlView: DetailProtocol {
    func hideLoader() {
        self.hideIndicator()
    }
    
    func showLoader() {
        self.showIndicator()
    }
    
    func showError(_ message: String) {
        self.errorAlert(message: message)
    }
    
    func reloadData() {
        guard let pokemon = presenter.pokemon else {
            self.errorAlert(message: .msgTryLater)
        return
        }
        
        self.title = pokemon.name?.uppercased()
        lblNum.text = pokemon.id?.description
        lblName.text = pokemon.name?.uppercased()
        
        
        if let frontDefault = pokemon.sprites?.front_default {
            imgFronNormal.imageFromServerUrl(urlString: frontDefault,
                                             placeholder: UIImage(named: Constants.Images.pokeball) ?? UIImage())
        }
        
        if let frontShiny = pokemon.sprites?.front_shiny {
            imgFronShinyl.imageFromServerUrl(urlString: frontShiny,
                                             placeholder: UIImage(named: Constants.Images.pokeball) ?? UIImage())
        }
        
        if let types = pokemon.types {
            managerTypes.setData(data: types)
            collTypes.reloadData()
            
            managerTypes.selectedIndex = { name in
                self.presenter.selectedPokemon(name: name)
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        if let stats = pokemon.stats {
            managerStats.setData(data: stats)
            tblStats.reloadData()
        }
    }
}
