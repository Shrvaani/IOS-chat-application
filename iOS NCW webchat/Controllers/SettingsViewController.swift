//
//  SettingsViewController.swift
//  iOS NCW webchat
//
//  Created by Alexander on 16/02/23.
//

import UIKit

final class SettingsViewController: UIViewController {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.circle")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let lable: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 24, weight: .medium)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = .label
        return lable
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.red, for: .normal)
        button.setTitle("SIGN OUT", for: .normal)
        return button
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(lable)
        view.addSubview(button)
        
        lable.text = ChatManager.shared.currentUser
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        addContraints()

    }
    
    @objc private func didTapButton(){
        ChatManager.shared.signOut()
        let vc = UINavigationController(rootViewController: LoginViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    private func addContraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            lable.leftAnchor.constraint(equalTo: view.leftAnchor),
            lable.rightAnchor.constraint(equalTo: view.rightAnchor),
            lable.heightAnchor.constraint(equalToConstant: 100),
            lable.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            
            button.leftAnchor.constraint(equalTo: view.leftAnchor),
            button.rightAnchor.constraint(equalTo: view.rightAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.topAnchor.constraint(equalTo: lable.bottomAnchor, constant: 20),
            


        ])
        
    }
    


}
