//
//  taskCell.swift
//  TodoApp
//
//  Created by alihizardere on 12.04.2024.
//

import UIKit

protocol TaskCellProtocol : AnyObject {
    func deleteTask(sender: TaskCell, index: Int)
}

class TaskCell: UICollectionViewCell {
    // MARK: - Properties
    var index: Int?
    
    var task: Task? {
        didSet{ configure() }
    }
    
    weak var delegate: TaskCellProtocol?
    
    private lazy var circleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.tintColor = .systemGreen.withAlphaComponent(0.7)
        button.addTarget(self, action: #selector(handleCircleButton), for: .touchUpInside)
        return button
    }()
    
    private let taskLabel: UILabel = {
      let label = UILabel()
      label.numberOfLines = 0
      return label
    }()
    
    // MARK: - Lifecyle
    override init(frame: CGRect) {
        super.init(frame: frame)
        reload()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reload(){
        style()
        layout()
    }
}

// MARK: - Selectors
extension TaskCell {
    @objc private func handleCircleButton(_ sender: UIButton){
        UIView.animate(withDuration: 0.5, delay: 0) {
            self.circleButton.alpha = 0
        } completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0) {
                self.circleButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
                self.circleButton.alpha = 1
            } completion: { _ in
                guard let task = self.task else { return }
                guard let index = self.index else{ return }
                Service.deleteTask(task: task)
                self.delegate?.deleteTask(sender: self, index: index)
            }
            
        }
        
    }
}

// MARK: - Helpers
extension TaskCell {
    private func style(){
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.5
        circleButton.setImage(UIImage(systemName: "circle"), for: .normal)
        circleButton.translatesAutoresizingMaskIntoConstraints = false
        taskLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout(){
        addSubview(circleButton)
        addSubview(taskLabel)
        
        NSLayoutConstraint.activate([
        
            circleButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            circleButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            circleButton.heightAnchor.constraint(equalToConstant: 50),
            circleButton.widthAnchor.constraint(equalToConstant: 50),
            
            taskLabel.leadingAnchor.constraint(equalTo: circleButton.trailingAnchor, constant: 8),
            taskLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            taskLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            taskLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        
        ])
    }
    
    private func configure() {
        guard let task = task else { return }
        taskLabel.text = task.text
    }
}
