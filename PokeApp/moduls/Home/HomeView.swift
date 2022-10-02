//
//
// HomeView.swift
// PokeApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 28/09/22.
// Copyright (c) 2022 and Confidential to MIGUEL ROBLEDO All rights reserved.
//


import UIKit

class HomeView: UIViewController {
    lazy var presenter: HomePresenterProtocol = HomePresenter(delegate: self)
    
    @IBOutlet weak var searchPokemon: UISearchBar!
    
    @IBOutlet weak var lblPokemonCount: UILabel!
    
    @IBOutlet weak var collPokemon: UICollectionView!
    private var barButton: UIBarButtonItem?
    private var manager = ManagerPokemonColl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCell()
        self.initialView()
        self.createBarButton()
        // Do any additional setup after loading the view.
        DispatchQueue.main.async {
            self.callApiRest()
        }
    }
    
    private func registerCell() {
        collPokemon.register(UINib(nibName: "PokemonCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
    
    private func initialView() {
        collPokemon.dataSource = self
        collPokemon.delegate = self
        
        searchPokemon.delegate = self
    }
    
    private func callApiRest() {
        presenter.getPokemons()
    }
    
    private func goToDetail(idPokemon: Int) {
        self.view.endEditing(true)
        
        let vc = DetailRouter.createView(idPokemon: idPokemon, delegate: self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func createBarButton() {
        let image = UIImage(systemName: Constants.Images.allPokemon)
        barButton  = UIBarButtonItem(image: image, landscapeImagePhone: image, style: .plain, target: self, action: #selector(reloadHome))
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    private func errorAlert(message: String) {
        let alert = UIAlertController(title: .titleSomethingWentWrong, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: .Continue, style: .default, handler: { _ in
            self.searchPokemon.text = ""
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func reloadCount() {
        let lblResult: String = .lblResults
        lblPokemonCount.text = "\(self.presenter.pokemons.count) \(lblResult)"
    }
    
    private func showAlertSearch() {
        guard let searchText = searchPokemon.text else {
            return
        }
        let alert = UIAlertController(title: .txtSearch, message: .txtSelectedSearchType, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: .txtType, style: .default, handler: { _ in
            self.presenter.getPokemonsByType(searchText)
        }))
        alert.addAction(UIAlertAction(title: .txtPokemon, style: .default, handler: { _ in
            self.presenter.searchPokemon(searchText)
        }))
        alert.addAction(UIAlertAction(title: .Cancelar, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension HomeView: HomeProtocol {
    func hideLoader() {
        self.hideIndicator()
    }
    
    func showLoader() {
        self.showIndicator()
    }
    
    func showError(_ message: String) {
        DispatchQueue.main.async {
            self.errorAlert(message: message)
        }
    }
    
    
    func reloadData() {
        DispatchQueue.main.async {
            self.reloadCount()
            self.initialView()
            self.collPokemon.reloadData()
        }
    }
    
    
    func reloadTypesPokemonData() {
        self.reloadCount()
        manager.setData(data: presenter.pokemons)
        collPokemon.dataSource = manager
        collPokemon.delegate = manager
        
        manager.selectedPokemon = { idPokemon in
            self.goToDetail(idPokemon: idPokemon)
        }
        collPokemon.reloadData()
    }
}

extension HomeView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != "" {
            searchBar.resignFirstResponder()
            showAlertSearch()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}


extension HomeView: PokemonTypeDelegate {
    func pokemonTypeSelected(name: String) {
        searchPokemon.text = ""
        
        let pokemonTypes: String = .lblPokemonTypes
        self.title = "\(name.uppercased()) \(pokemonTypes)"
        
        presenter.getPokemonsByType(name)
    }
     
    @objc func reloadHome() {
        self.view.endEditing(true)
        self.title = .titleHome
        searchPokemon.text = ""
        presenter.removePokemons()
        presenter.getPokemons()
    }
    
}



extension HomeView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PokemonCell
        
        let pokemon  = presenter.pokemons[indexPath.row]
        cell.pokemon = pokemon
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == presenter.pokemons.count - 1 {
            updateNextSet()
        }
    }
    
    func updateNextSet() {
        presenter.getPokemons()
    }
}

extension HomeView: UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let idPokemon = presenter.pokemons[indexPath.row].idPokemon else {
            return
        }
        
        goToDetail(idPokemon: idPokemon)
    }
}

extension HomeView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width - 27) / 3)
        
        return CGSize(width: width, height: width + 20)
    }
}
