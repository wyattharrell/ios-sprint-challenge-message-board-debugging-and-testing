//
//  MessageThreadController+UITesting.swift
//  Message Board
//
//  Created by Spencer Curtis on 9/14/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

extension MessageThreadController {
    
    func fetchLocalMessageThreads(completion: @escaping (Error?) -> Void) {
        
        do {
            let mockData = try Data(contentsOf: mockDataURL)
            
            self.messageThreads = Array(try JSONDecoder().decode([String: MessageThread].self, from: mockData).values)
            
        } catch {
            NSLog("Error decoding mock data: \(error)")
            completion(error)
        }
        
        completion(nil)
    }
    
    func createLocalMessageThread(with title: String, completion: @escaping (Error?) -> Void) {
        let thread = MessageThread(title: title)
        messageThreads.append(thread)
        
        completion(nil)
    }
    
    func createLocalMessage(in messageThread: MessageThread, withText text: String, sender: String, completion: @escaping (Error?) -> Void) {
        
        guard let index = messageThreads.index(of: messageThread) else { completion(NSError()); return }
        
        let message = MessageThread.Message(text: text, sender: sender)
        messageThreads[index].messages.append(message)
        
        completion(nil)
    }
    
    var mockDataURL: URL {
        return Bundle.main.url(forResource: "MockMessages", withExtension: "json")!
    }
}
