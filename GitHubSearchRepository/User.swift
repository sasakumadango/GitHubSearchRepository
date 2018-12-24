//
//  User.swift
//  GitHubSearchRepository
//
//  Created by Yuta S. on 2018/03/18.
//  Copyright © 2018 Yuta S. All rights reserved.
//

import Foundation

struct User: JSONDecodable {
    let id: Int
    let login: String
    
    init(json: Any) throws {
        Debug.PRINT_LOG()
        guard let dictionary = json as? [String : Any] else {
            throw JSONDecoderError.invalidFormat(json: json)
        }
        
        guard let id = dictionary["id"] as? Int else {
            throw JSONDecoderError.missingValues(key: "id", actualValue: ["id"])
        }
        
        guard let login = dictionary["login"] as? String else {
            throw JSONDecoderError.missingValues(key: "Login", actualValue: ["Login"])
        }
        
        self.id = id
        self.login = login
    }
}
