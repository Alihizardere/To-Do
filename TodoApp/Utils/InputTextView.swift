//
//  InputTextView.swift
//  TodoApp
//
//  Created by alihizardere on 11.04.2024.
//

import UIKit

class InputTextView: UITextView {
    // MARK: - Properties
    var placeHolder: String? {
        didSet {self.inputPlaceholder.text = placeHolder}
    }
    private let inputPlaceholder: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .lightGray
        return label
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Selector
extension InputTextView {
    @objc private func handleTextDidChange(){
        inputPlaceholder.isHidden = !text.isEmpty
    }
}


// MARK: - Helpers
extension InputTextView {
    private func style(){
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChange), name: UITextView.textDidChangeNotification, object: nil)
        inputPlaceholder.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout(){
        addSubview(inputPlaceholder)
        
        NSLayoutConstraint.activate([
            inputPlaceholder.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            inputPlaceholder.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4)
        ])
    }
}
