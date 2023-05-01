//
//  ChatManager.swift
//  iOS NCW webchat
//
//  Created by Alexander on 16/03/23.
//

import StreamChat
import StreamChatUI
import Foundation

final class ChatManager{
    static let shared = ChatManager()
    private var client: ChatClient!
    private let tokens = [
        "shrvaani":
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoic2hydmFhbmkifQ.LybidkzgdjnU4sU5omcxsQ6kMEMxV3nxet1X2BkP30w",
        "angeline": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiYW5nZWxpbmUifQ.Jc2SX_HKkBvhBX0B9J3xaEITWHVx_FfNFfGx6gktrq8"
    ]
    
    func setUp(){
        let client = ChatClient(config: .init(apiKey: .init("h77nn5tpd9nr")))
        self.client = client
    }
    
    // Authentication
    //signin
    
    
    func signIn(with username: String, completion: @escaping (Bool) -> Void){
        guard !username.isEmpty else{
            completion(false)
            
            return
        }
        guard let token =  tokens[username.lowercased()] else {
            completion(false)
            return
        }
        client.connectUser(
            userInfo: UserInfo(id: username, name: username),
            token: Token(stringLiteral: token)
        ) { error in
                completion(error == nil)
            }
        
    }
    
    //signout
    
    
    func signOut()
    {
        client.disconnect()
        client.logout()
    }
    
    //return value
    
    
    var isSignedIn: Bool{
        return client.currentUserId != nil
    }
    var currentUser: String? {
        return client.currentUserId
    }
    
    //ChannelList, Creation
    
    
    public func createChannelList() -> UIViewController? {
        guard let id = currentUser else {
            return nil
        }
        let list = client.channelListController(query: .init(filter: .containMembers(userIds: [id])))
        let vc = ChatChannelListVC()
        vc.content = list
        list .synchronize()
        return vc
    }
    public func createNewChannel(name: String){
        guard let current = currentUser else{
            return
        }
        let keys: [String] = tokens.keys.filter({ $0 != current }).map { $0 }
        do {
            let result = try client.channelController(
                createChannelWithId: .init(type: .messaging, id: name),
                name: name,
                members: Set(keys),
                isCurrentUserMember: true
            )
            result.synchronize()
        }
        catch{
            print("\(error)")
        }
    }
}
