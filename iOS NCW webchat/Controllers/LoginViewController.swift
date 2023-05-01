//
//  ViewController.swift
//  iOS NCW webchat
//
//  Created by Alexander on 15/02/23.
//

import UIKit

/*
 -login screen
 -channel list/chat list
 -message
 -create chat/channels
 -settings(log out)
 */

final class LoginViewController: UIViewController {
    private let userameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username"
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .secondarySystemBackground
        return field
    }()
    private let button: UIButton = {
            let button = UIButton()
            button.backgroundColor = .systemCyan
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitleColor(.white, for: .normal)
            button.setTitle("CONTINUE", for: .normal)
            button.layer.cornerRadius = 8
            button.layer.masksToBounds = true
            
            return button
            
        }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "NCW WEBCHAT"
        view.backgroundColor = .systemBackground
        view.addSubview(userameField)
        view.addSubview(button)
        addConstraints()
        button.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)

    }
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        userameField.becomeFirstResponder()
        if ChatManager.shared.isSignedIn{
            presentChatList(animated: false)
        }
    }
    private func addConstraints(){
        NSLayoutConstraint.activate([
            userameField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            userameField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 50),
            userameField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -50),
            userameField.heightAnchor.constraint(equalToConstant: 50),
            button.topAnchor.constraint(equalTo: userameField.bottomAnchor, constant: 20),
            button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
    }
    @objc private func didTapContinue(){
        userameField.resignFirstResponder()
        guard let text = userameField.text, !text.isEmpty else{
            return
        }
        ChatManager.shared.signIn(with: text) { [weak self]success in
            guard success else{
                return
            }
            print("did login")
            //take user to the chat list
            DispatchQueue.main.async {
                self?.presentChatList()
            }
        }
    }
    func presentChatList(animated: Bool = true){
        print("should show chat list")
        guard let vc = ChatManager.shared.createChannelList() else { return }
        
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose,
                                                               target: self,
                                                               action: #selector(didTapCompose))
        
        
        let tabVC = TabBarViewController(chatList: vc)
        tabVC.modalPresentationStyle = .fullScreen
        present(tabVC, animated: animated)
    }
    @objc private func didTapCompose(){
        let alert  = UIAlertController(title: "NEW CHAT",
                                       message: "ENTER CHANNEL NAME",
                                       preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(.init(title: "CANCEL", style: .cancel))
        alert.addAction(.init(title: "CREATE", style: .default, handler: { _ in
            guard let text = alert.textFields?.first?.text, !text.isEmpty  else{
                return
            }
            DispatchQueue.main.async {
                ChatManager.shared.createNewChannel(name: text)
            }
        }))

        
        presentedViewController?.present(alert, animated: true)
    }
}

