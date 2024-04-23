//
//  RegisterViewModel.swift
//  TodoApp
//
//  Created by alihizardere on 8.04.2024.
//

import UIKit

struct RegisterViewModel {
    var nameTextField:String?
    var usernameTextField:String?
    var emailTextField:String?
    var passwordTextField:String?
    
    var status:Bool {
        return nameTextField?.isEmpty == false && usernameTextField?.isEmpty == false && emailTextField?.isEmpty == false && passwordTextField?.isEmpty == false
    }
}

