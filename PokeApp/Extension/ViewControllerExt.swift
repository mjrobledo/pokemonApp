//
//
// ViewController.swift
// PokeApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 29/09/22.
// Copyright (c) 2022 and Confidential to MIGUEL ROBLEDO All rights reserved.
//


import Foundation
import MBProgressHUD

extension UIViewController {
    //MARK:- MBProgressHUD
    
    /// Abre un indicador Loader para informar que se está realizando alguna acción
    /// - Parameters:
    ///   - title: Descripción general
    ///   - Description: Texto informativo Subtitulo
    func showIndicator(withTitle title: String? = "", and Description:String? = "") {
        DispatchQueue.main.async {
            let Indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
            Indicator.label.text = title
            Indicator.isUserInteractionEnabled = false
            Indicator.detailsLabel.text = Description
            Indicator.show(animated: true)
        }
    }
    
    ///Oculta el indicador Loader de la vista
    func hideIndicator() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}
