//
//  pastTaskCell.swift
//  TodoApp
//
//  Created by alihizardere on 13.04.2024.
//

import UIKit

class PastTaskCell: UICollectionViewCell {
    // MARK: - Properties
    var task: Task?{
        didSet{configure()}
    }
    private let circleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        button.tintColor = .lightGray
        return button
        
    }()
    private let taskLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .lightGray
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
extension PastTaskCell {
    private func style(){
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.5
        circleButton.translatesAutoresizingMaskIntoConstraints = false
        taskLabel.translatesAutoresizingMaskIntoConstraints = false
        
    }
    private func layout(){
        addSubview(circleButton)
        addSubview(taskLabel)
        
        NSLayoutConstraint.activate( [
        
            circleButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            circleButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            circleButton.widthAnchor.constraint(equalToConstant: 50),
            circleButton.heightAnchor.constraint(equalToConstant: 50),
            
            taskLabel.leadingAnchor.constraint(equalTo: circleButton.trailingAnchor, constant: 8),
            taskLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            taskLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            taskLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        
        ])
    }
    private func configure() {
        guard let task = self.task else { return }
        taskLabel.text = task.text  
    }
}
