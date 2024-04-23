//
//  CustomProfileView.swift
//  TodoApp
//
//  Created by alihizardere on 14.04.2024.
//

import UIKit

class  CustomProfileView: UIView {
    init(label: UILabel) {
        super.init(frame: .zero)
        layer.borderColor = UIColor.white.withAlphaComponent(0.6).cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 10
        
        let label = label
        label.textColor = .white.withAlphaComponent(0.8)
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
        ])
    
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
