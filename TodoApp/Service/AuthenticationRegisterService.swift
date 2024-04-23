//
//  AuthenticationRegister.swift
//  TodoApp
//
//  Created by alihizardere on 9.04.2024.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

struct AuthenticationRegisterUserModel {
    let nameText: String
    let usernameText: String
    let emailText: String
    let passwordText: String
    let profileImage: UIImage
}

struct AuthenticationRegisterService {
    
    static func logIn(emailText:String, passwordText:String, completion: @escaping (AuthDataResult?, Error?)-> Void){
        Auth.auth().signIn(withEmail: emailText, password: passwordText, completion: completion)
    }
    
    static func createUser(user: AuthenticationRegisterUserModel, completion: @escaping (Error?) -> Void ){
        guard let profileImageData = user.profileImage.jpegData(compressionQuality: 0.5) else {return}
        let file = NSUUID().uuidString
        let reference = Storage.storage().reference(withPath: "images/profile_images/\(file)")
        
        reference.putData(profileImageData) { metaData, error in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            reference.downloadURL { url, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                guard let profileImageUrl = url?.absoluteString else {return}
                
                Auth.auth().createUser(withEmail: user.emailText, password: user.passwordText) { result, error in
                    
                    guard let uid = result?.user.uid else {return}
                    
                    let data = [
                        "name": user.nameText,
                        "username": user.usernameText,
                        "email": user.emailText,
                        "password": user.passwordText,
                        "profileImageUrl": profileImageUrl,
                        "uid": uid,
                    ] as [String : Any]
                    
                    Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
                }
                
            }
        }
        
    }
}
