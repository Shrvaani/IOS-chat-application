//
//  TabBarViewController.swift
//  iOS NCW webchat
//
//  Created by Alexander on 16/02/23.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    let chatList: UIViewController
    init(chatList: UIViewController) {
        self.chatList = chatList
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViewControllers()

    }
    private func setUpViewControllers(){
        let settings = SettingsViewController()
        let nav1 = UINavigationController(rootViewController: chatList)
        let nav2 = UINavigationController(rootViewController: settings)
        
        nav1.tabBarItem = UITabBarItem(title: "chat",
                                       image: UIImage(systemName: "message"),
                                       tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "settings",
                                       image: UIImage(systemName: "gear"),
                                       tag: 2)

        setViewControllers([nav1, nav2], animated: true)
    }
    
    
}
