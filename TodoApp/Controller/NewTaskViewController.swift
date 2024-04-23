//
//  NewTaskViewController.swift
//  TodoApp
//
//  Created by alihizardere on 11.04.2024.
//

import UIKit

class NewTaskViewController: UIViewController {
    // MARK: - Properties
    private let newTaskLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString(string: "New Task", attributes: [.foregroundColor: UIColor.white, .font: UIFont.preferredFont(forTextStyle: .largeTitle)])
        label.textAlignment = .center
        return label
    }()
    
    private let textView: InputTextView = {
       let inputTextView = InputTextView()
       inputTextView.placeHolder = "Enter New Task.."
       inputTextView.font = UIFont.systemFont(ofSize: 20)
       inputTextView.layer.borderWidth = 3
       inputTextView.layer.borderColor = UIColor.lightGray.cgColor
       inputTextView.layer.cornerRadius = 10
       return inputTextView
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleCancelButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return button
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleAddButton), for: .touchUpInside)
        return button
    }()
    
    private var stackView = UIStackView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        style()
        layout()
    }
}

// MARK: -  Selectors
extension NewTaskViewController {
    
    @objc private func handleCancelButton(_ sender: UIButton){
        self.dismiss(animated: true)
    }
    
    @objc private func handleAddButton(_ sender: UIButton){
        guard let taskText = textView.text else { return }
        
        Service.sendTask(text: taskText) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
        }
        self.dismiss(animated: true)
    }
}

// MARK: - Helpers
extension NewTaskViewController {
    private func style(){
        view.backgroundColor = .black.withAlphaComponent(0.7)
        newTaskLabel.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        stackView = UIStackView(arrangedSubviews: [cancelButton,addButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.distribution = .fillEqually
        
    }
    
    private func layout(){
        view.addSubview(newTaskLabel)
        view.addSubview(textView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
        
            newTaskLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            newTaskLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            newTaskLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            textView.topAnchor.constraint(equalTo: newTaskLabel.bottomAnchor, constant: 32),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textView.heightAnchor.constraint(equalToConstant: view.bounds.height / 5),
            
            stackView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            
            
        ])
    }
}
