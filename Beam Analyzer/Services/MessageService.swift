//
//  MessageService.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 29.03.2023.
//

import Foundation
import Firebase

final class MessageService {
    
    static let shared = MessageService()
    
    private let firestore = Firestore.firestore()
    private let bodyField = "body"
    private let senderField = "sender"
    private let dateField = "date"
    private let conversationsField = "conversations"
    private let conversationUsernamesField = "conversation_usernames"
    private init() { }

    var conversationsListener: ListenerRegistration?
    
    func sendMessage(message: String, currentUserName: String, receiverUserName: String) {
        let conversationTitle = getConversationTitle(currentUserName: currentUserName, receiverUserName: receiverUserName)
        firestore.collection(conversationTitle).addDocument(data: [bodyField: message, senderField: currentUserName, dateField: Date().timeIntervalSince1970])
    }
    
    func loadMessages(currentUserName: String, receiverUserName: String, completionHandler: @escaping (Result<[Message], Error>) -> Void) {
        let conversationTitle = getConversationTitle(currentUserName: currentUserName, receiverUserName: receiverUserName)
        var messages: [Message] = []
        firestore.collection(conversationTitle).order(by: dateField).addSnapshotListener { (querySnapshot, error) in
            if let error {
                completionHandler(.failure(error))
                return
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let dateInterval = data[self.dateField] as? Double, let body = data[self.bodyField] as? String, let sender = data[self.senderField] as? String {
                            let dateString = DateUtil.getString(from: Date(timeIntervalSince1970: dateInterval))
                            let message = Message(sender: sender, body: body, date: dateString)
                            messages.append(message)
                        }
                    }
                }
                completionHandler(.success(messages))
                messages = []
            }
        }
        
    }
    
    func createConversations(currentUserName: String, receiverUserName: String) {
        addConversation(documentUserName: currentUserName, otherUserName: receiverUserName)
        addConversation(documentUserName: receiverUserName, otherUserName: currentUserName)
    }
    
    func removeConversationsListener() {
        conversationsListener?.remove()
    }
    
    func fetchConversations(userName: String, completionHandler: @escaping (Result<[String], Error>) -> Void) {
        conversationsListener = firestore.collection(conversationsField).document(userName).addSnapshotListener { document, error in
            if let document = document, document.exists {
                let data = document.data()
                let conversationUserNames = data?[self.conversationUsernamesField] as? [String] ?? []
                completionHandler(.success(conversationUserNames))
            } else if let error {
                completionHandler(.failure(error))
            } else {
                completionHandler(.success([]))
            }
        }
    }
    
    private func addConversation(documentUserName: String, otherUserName: String) {
        
        firestore.collection(conversationsField).document(documentUserName).getDocument { [self] document, _ in
            if let document = document, document.exists {
                let data = document.data()
                var conversationUserNames = data?[self.conversationUsernamesField] as? [String] ?? []
                
                if !conversationUserNames.contains(otherUserName) {
                    conversationUserNames.append(otherUserName)
                    self.firestore.collection(conversationsField).document(documentUserName).updateData([conversationUsernamesField: conversationUserNames])
                }
            } else {
                self.firestore.collection(conversationsField).document(documentUserName).setData([conversationUsernamesField: [otherUserName]])
            }
        }
    }
    
    private func getConversationTitle(currentUserName: String, receiverUserName: String) -> String {
        let conversationTitle = [currentUserName, receiverUserName].sorted().joined(separator: "*")
        return conversationTitle
    }
    
}
