//
//  Repository.swift
//  GitHubSearchRepository
//
//  Created by Yuta S. on 2018/03/18.
//  Copyright © 2018 Yuta S. All rights reserved.
//

import Foundation

struct Repository: JSONDecodable {
    let id: Int
    let name: String
    let fullName: String
    let owner: User
    
    init(json: Any) throws {
        Debug.PRINT_LOG()
        guard let dictionary = json as? [String : Any] else {
            throw JSONDecoderError.invalidFormat(json: json)
        }
        
        guard let id = dictionary["id"] as? Int else {
            throw JSONDecoderError.missingValues(key: "id", actualValue: ["id"])
        }
        
        guard let name = dictionary["name"] as? String else {
            throw JSONDecoderError.missingValues(key: "name", actualValue: ["name"])
        }
        
        guard let fullName = dictionary["full_name"] as? String else {
            throw JSONDecoderError.missingValues(key: "full_name", actualValue: ["full_name"])
        }
        
        guard let ownerObject = dictionary["owner"] else {
            throw JSONDecoderError.missingValues(key: "owner", actualValue: dictionary["owner"] as Any)
        }
        
        self.id = id
        self.name = name
        self.fullName = fullName
        self.owner = try User(json: ownerObject)
    }
}
