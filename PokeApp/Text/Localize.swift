//
//
// Localize.swift
// PokeApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 02/10/22.
// Copyright (c) 2022 and Confidential to MIGUEL ROBLEDO All rights reserved.
//


import Foundation

/**
 Contiene todos los accesos a cada una de las descripciones de texto, para mostrar alertas, títulos de menú, etiquetas etc.
 */
func localizedString(forKey key: String) -> String {
   
    var result = Bundle.main.localizedString(forKey: key, value: nil, table: nil)

    if result == key {
        result = Bundle.main.localizedString(forKey: key, value: nil, table: "Localize")
    }

    return result
}

extension String {
    static let titleSomethingWentWrong = localizedString(forKey: "titleSomethingWentWrong")
    static let Continue = localizedString(forKey: "Continue")
    static let lblReloadAll = localizedString(forKey: "lblReloadAll")
    static let msgTryLater = localizedString(forKey: "msgTryLater")
    static let lblPokemonTypes = localizedString(forKey: "lblPokemonTypes")
    static let titleHome = localizedString(forKey: "titleHome")
    static let msgNotFound = localizedString(forKey: "msgNotFound")
    static let lblResults = localizedString(forKey: "lblResults")
    static let txtSearch = localizedString(forKey: "txtSearch")
    static let txtSelectedSearchType = localizedString(forKey: "txtSelectedSearchType")
    static let txtType = localizedString(forKey: "txtType")
    static let txtPokemon = localizedString(forKey: "txtPokemon")
    static let Cancelar = localizedString(forKey: "Cancelar")
    
}
