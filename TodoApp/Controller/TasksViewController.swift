//
//  TaskViewController.swift
//  TodoApp
//
//  Created by alihizardere on 10.04.2024.
//

import UIKit
import FirebaseAuth


class TasksViewController: UIViewController {
    // MARK: - Properties
    var user: User? {
        didSet{ configure() }
    }
    var tasks = [Task]()
    
    private lazy var newTaskButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus.diamond.fill" ), for: .normal)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleNewTaskButton), for: .touchUpInside)
        return button
    }()
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let nameLabel: UILabel = {
       let label = UILabel()
       label.text = "  "
       label.textColor = .white
       label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
       return label
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        style()
        layout()
        
    }
}

// MARK: - Selector
extension TasksViewController {
    @objc private func handleNewTaskButton(_ sender: UIButton){
        let controller = NewTaskViewController()
        if let sheet = controller.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        present(controller, animated: true)
    }
}
// MARK: - Service

extension TasksViewController {

    private func fetchTasks(){
        guard let uid = user?.uid else {return}
        Service.fetchTasks(uid: uid) { tasks in
            self.tasks = tasks
            self.collectionView.reloadData()
        }
    }
}

// MARK: - Helpers
extension TasksViewController {
    private func style(){
        backgroundGradientColor()
        navigationController?.navigationBar.isHidden = true
        newTaskButton.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TaskCell.self, forCellWithReuseIdentifier: "taskCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout(){
        view.addSubview(collectionView)
        view.addSubview(newTaskButton)
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            
            newTaskButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            newTaskButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            newTaskButton.heightAnchor.constraint(equalToConstant: 60),
            newTaskButton.widthAnchor.constraint(equalToConstant: 60),
            
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            collectionView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -14)
        
        ])
    }
    
    private func configure() {
        guard let user = user  else {return}
        nameLabel.text = "Hi \(user.name) 👋🏻"
        fetchTasks()
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension TasksViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "taskCell", for: indexPath) as! TaskCell
        cell.task =  tasks[indexPath.row]
        cell.delegate = self
        cell.index = indexPath.row
        
        return cell
    }
}

extension TasksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width * 0.9
        let cell = TaskCell(frame: .init(x: 0, y: 0, width: width, height: 50))
        cell.task = tasks[indexPath.row]
        cell.layoutIfNeeded()
        let copySize = cell.systemLayoutSizeFitting(.init(width: width, height: 1000))
        return .init(width: width, height: copySize.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: 10, height: 10)
    }
}

// MARK: -  TaskCellProtocol
extension TasksViewController: TaskCellProtocol {
    func deleteTask(sender: TaskCell, index: Int) {
        sender.reload()
        self.tasks.remove(at: index)        
        collectionView.reloadData()
    }
}
