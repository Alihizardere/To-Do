//
//  PastTasksViewController.swift
//  TodoApp
//
//  Created by alihizardere on 10.04.2024.
//

import UIKit

class PastTaskViewController: UIViewController {
    // MARK: - Properties
    var user: User?{
        didSet{ configure()}
    }
    var pastTasks = [Task]()
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return collectionView
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        style()
        layout()
    }
}
// MARK: -  Service
extension PastTaskViewController {
    func fetchPastTasks(uid: String){
        Service.fetchPastTasks(uid: uid) { tasks in
            self.pastTasks = tasks
            self.collectionView.reloadData()
        }
    }
}

// MARK: -  Helpers
extension PastTaskViewController {
    private func style(){
        backgroundGradientColor()
        collectionView.backgroundColor = .clear 
        collectionView.register(PastTaskCell.self, forCellWithReuseIdentifier: "pastTaskCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    private func layout(){
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
        
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -14)
        ])
    }
    private func configure() {
        guard let user = self.user else { return }
        fetchPastTasks(uid: user.uid)
    }
}
// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension PastTaskViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pastTasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pastTaskCell", for: indexPath) as! PastTaskCell
        cell.task = pastTasks[indexPath.row]
        return cell
    }
}

extension PastTaskViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width * 0.9
        let cell = TaskCell(frame: .init(x: 0, y: 0, width: width, height: 50))
        cell.task = pastTasks[indexPath.row]
        cell.layoutIfNeeded()
        let copySize = cell.systemLayoutSizeFitting(.init(width: width, height: 1000))
        return .init(width: view.frame.width * 0.9 , height: copySize.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: 10, height: 10)
    }
}
