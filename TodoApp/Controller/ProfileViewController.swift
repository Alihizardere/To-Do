//
//  ProfileViewController.swift
//  TodoApp
//
//  Created by alihizardere on 10.04.2024.
//

import UIKit
import FirebaseAuth
import SDWebImage


class ProfileViewController: UIViewController {
    // MARK: - Properties
    var user: User? {
        didSet { configure() }
    }
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var nameContainerView: CustomProfileView = {
       let customView = CustomProfileView(label: nameLabel)
       return customView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var usernameContainerView: CustomProfileView = {
       let customView = CustomProfileView(label: usernameLabel)
       return customView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var emailContainerView: CustomProfileView = {
       let customView = CustomProfileView(label: emailLabel)
       return customView
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .mainColor
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleSignOutButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    private var stackView = UIStackView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        style()
        layout()
    }
}

// MARK: - Selectors
extension ProfileViewController {
    @objc private func handleSignOutButton(_ sender: UIButton){
        do{
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                let controller = UINavigationController(rootViewController: LoginViewController())
                controller.modalPresentationStyle = .fullScreen
                self.present(controller, animated: true)
            }
        } catch {
            
        }
    }
}
// MARK: - Helpers
extension ProfileViewController {
    private func style(){
        backgroundGradientColor()
        profileImageView.layer.cornerRadius = 160 / 2
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.borderWidth = 3
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView = UIStackView(arrangedSubviews: [nameContainerView, usernameContainerView, emailContainerView, signOutButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func layout(){
        view.addSubview(profileImageView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 160),
            profileImageView.heightAnchor.constraint(equalToConstant: 160),
            
            stackView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
            
        ])
    }
    
    private func configure(){
        guard let user = self.user else { return }
        guard let url = URL(string: user.profieImageUrl) else { return }
        profileImageView.sd_setImage(with: url)
        nameLabel.text = user.name
        usernameLabel.text = user.username
        emailLabel.text = user.email
        
    }
}
