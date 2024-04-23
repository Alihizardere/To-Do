//
//  RegisterViewController.swift
//  TodoApp
//
//  Created by alihizardere on 8.04.2024.
//

import UIKit

class RegisterViewController: UIViewController {
    // MARK: - Properties
    private var viewModel = RegisterViewModel()
    private var profileImage: UIImage?
    
    private lazy var cameraButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "camera.circle"), for: .normal)
        button.tintColor = .white
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.clipsToBounds = true
        button.layer.cornerRadius = 75
        button.addTarget(self, action: #selector(handleChoosePhoto), for: .touchUpInside)
        return button
    }()
    
    private lazy var nameContainerView: UIView = {
       let containerView = AuthenticationInputView(image: UIImage(systemName: "person")!, textField: nameTextField)
        return containerView
    }()
    
    private lazy var usernameContainerView: UIView = {
       let containerView = AuthenticationInputView(image: UIImage(systemName: "person")!, textField: usernameTextField)
       return containerView
    }()
    
    private lazy var emailContainerView: UIView = {
       let containerView = AuthenticationInputView(image: UIImage(systemName: "envelope")!, textField: emailTextField)
       return containerView
    }()
    
    private lazy var passwordContainerView: UIView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "lock")!, textField: passwordTextField)
        return containerView
    }()
    private let nameTextField: UITextField = {
        let textField = CustomTextField(placeHolder: "Name")
        return textField
    }()
    
    private let usernameTextField: UITextField = {
        let textField = CustomTextField(placeHolder: "Username")
        return textField
    }()
    
    private let emailTextField: UITextField = {
       let textField = CustomTextField(placeHolder: "Email")
       return textField
    }()
   
    private let passwordTextField: UITextField = {
        let textField = CustomTextField(placeHolder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.layer.cornerRadius = 7
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action:#selector(handleRegisterButton), for: .touchUpInside)
        return button
    }()
    
    private var stackView = UIStackView()
    
    private lazy var switchToLoginPage: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "If you are a member, Login Page", attributes: [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 14)])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleGoLogin), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        style()
        layout()
        
    }
    
}
// MARK: - Selectors
extension RegisterViewController {
    
    @objc private func handleRegisterButton(_ sender: UIButton){
        guard let emailText = emailTextField.text else {return}
        guard let passwordText = passwordTextField.text else {return}
        guard let nameText = nameTextField.text else {return}
        guard let usernameText = usernameTextField.text else {return}
        guard let profileImage = profileImage else {return}
        showHud(show: true)
        
       let user = AuthenticationRegisterUserModel(nameText: nameText, usernameText: usernameText, emailText: emailText, passwordText: passwordText, profileImage: profileImage)
        
        
        AuthenticationRegisterService.createUser(user: user) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                self.showHud(show: false)
                return
            }
            self.showHud(show: false)
            self.dismiss(animated: true)
        }
    }
    
    @objc private func handleChoosePhoto (_ sender: UIButton){
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc private func handleTextField (_ sender: UITextField){
        if sender == nameTextField {
            viewModel.nameTextField = sender.text
        } else if sender == usernameTextField {
            viewModel.usernameTextField = sender.text
        } else if sender ==  emailTextField {
            viewModel.emailTextField = sender.text
        } else {
            viewModel.passwordTextField = sender.text
        }
        registerButtonStatus()
    }
    
    @objc private func handleGoLogin(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleKeyboardWillShow(){
        view.frame.origin.y = -110
    }
    
    @objc private func handleKeyboardWillHide(){
        view.frame.origin.y = 0
    }
}

// MARK: - Helpers
extension RegisterViewController {
    
    private func registerButtonStatus(){
        if viewModel.status {
            registerButton.isEnabled = true
            registerButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        } else {
            registerButton.isEnabled = false
            registerButton.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
    }
    
    private func style(){
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        backgroundGradientColor()
        navigationController?.navigationBar.isHidden = true
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        stackView = UIStackView(arrangedSubviews: [nameContainerView, usernameContainerView, emailContainerView, passwordContainerView, registerButton])
        stackView.axis = .vertical
        stackView.spacing =  14
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        switchToLoginPage.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.addTarget(self, action: #selector(handleTextField), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(handleTextField), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(handleTextField), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handleTextField), for: .editingChanged)
        
    }
    
    private func layout(){
        view.addSubview(cameraButton)
        view.addSubview(stackView)
        view.addSubview(switchToLoginPage)
        
        NSLayoutConstraint.activate([
            
            cameraButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            cameraButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cameraButton.widthAnchor.constraint(equalToConstant: 150),
            cameraButton.heightAnchor.constraint(equalToConstant: 150),
            
            stackView.topAnchor.constraint(equalTo: cameraButton.bottomAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            switchToLoginPage.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
            switchToLoginPage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            switchToLoginPage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
        
        ])
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        profileImage = image
        cameraButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        cameraButton.layer.borderColor = UIColor.white.cgColor
        cameraButton.layer.borderWidth = 3
        self.dismiss(animated: true)
        
    }
}
