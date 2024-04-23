//
//  LoginViewModel.swift
//  TodoApp
//
//  Created by alihizardere on 7.04.2024.
//

import Foundation

struct LoginViewModel {
    var emailTextField: String?
    var passwordTextField: String?
    
    var status: Bool{
        return emailTextField?.isEmpty == false && passwordTextField?.isEmpty == false
    }
}
