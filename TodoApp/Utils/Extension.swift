//
//  Extension.swift
//  TodoApp
//
//  Created by alihizardere on 6.04.2024.
//

import UIKit
import JGProgressHUD

extension UIViewController {
    
    func backgroundGradientColor(){
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemOrange.cgColor, UIColor.systemPink.cgColor]
        gradient.locations = [0,1]
        gradient.frame = view.bounds
        view.layer.addSublayer(gradient)
    }
    
    func showHud(show: Bool){
        view.endEditing(true)
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.detailTextLabel.text = "Please wait"
        
        show ? hud.show(in: view) : hud.dismiss(animated: true)
    }
}

extension UIColor {
    static let mainColor = UIColor.orange.withAlphaComponent(0.7)
}
