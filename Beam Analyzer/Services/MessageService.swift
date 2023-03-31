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
    
    private init() { }

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
    
    private func getConversationTitle(currentUserName: String, receiverUserName: String) -> String {
        let conversationTitle = [currentUserName, receiverUserName].sorted().joined(separator: "*")
        return conversationTitle
    }
    
}
