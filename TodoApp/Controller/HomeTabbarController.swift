//
//  HomeViewController.swift
//  TodoApp
//
//  Created by alihizardere on 9.04.2024.
//

import UIKit
import FirebaseAuth

class HomeTabbarController: UITabBarController {
    // MARK: - Properties
    let pastTaskViewController = PastTaskViewController()
    let tasksViewController = TasksViewController()
    let profileViewController = ProfileViewController()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        userStatus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        style()
        fetchUser()
    }

}

// MARK: - Selectors
extension HomeTabbarController {
    private func fetchUser(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Service.fetchUser(uid: uid) { user in
            self.tasksViewController.user = user
            self.pastTaskViewController.user = user
            self.profileViewController.user = user
        }
    }
}

extension HomeTabbarController {
    
    private func style(){
        viewControllers = [
        configureViewControllers(rootViewController: pastTaskViewController, title: "Past Tasks", imageName: "clock.badge.checkmark"),
        configureViewControllers(rootViewController: tasksViewController, title: "Tasks", imageName: "checkmark.circle"),
        configureViewControllers(rootViewController: profileViewController, title: "Profile", imageName: "person.circle")
        ]
        configureTabbar()
    }
    
    private func userStatus(){
        if Auth.auth().currentUser?.uid == nil {
            DispatchQueue.main.async {
                let controller = UINavigationController(rootViewController: LoginViewController())
                controller.modalPresentationStyle = .fullScreen
                self.present(controller, animated: true)
            }
        } else {
            print("Kullanıcı var")
        }
    }
    
    private func configureViewControllers(rootViewController: UIViewController, title: String, imageName:String ) -> UINavigationController{
        let controller = UINavigationController(rootViewController: rootViewController)
        controller.tabBarItem.title = title
        controller.tabBarItem.image = UIImage(systemName: imageName)
        return controller
    }
    
    private func configureTabbar(){
        let shape = CAShapeLayer()
        let bezier = UIBezierPath(roundedRect: CGRect(x: 10, y:(self.tabBar.bounds.minY) - 14  , width: (self.tabBar.bounds.width) - 20, height: ((self.tabBar.bounds.height) + 28)), cornerRadius: ((self.tabBar.bounds.height) + 28) / 3 )
        shape.path = bezier.cgPath
        shape.fillColor = UIColor.white.cgColor
        self.tabBar.itemPositioning = .fill
        self.tabBar.itemWidth = ((self.tabBar.bounds.height) + 28) / 5
        self.tabBar.tintColor = UIColor.orange.withAlphaComponent(0.7)
        self.tabBar.unselectedItemTintColor = UIColor.lightGray
        self.tabBar.layer.insertSublayer(shape, at: 0)
        selectedIndex = 1
    }
}
