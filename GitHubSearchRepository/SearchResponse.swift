//
//  SearchResponse.swift
//  GitHubSearchRepository
//
//  Created by Yuta S. on 2018/03/18.
//  Copyright © 2018 Yuta S. All rights reserved.
//


import Foundation

struct SearchResponse<Item: JSONDecodable>: JSONDecodable {
    let totalCount: Int
    let items: [Item]
    
    init(json: Any) throws {
        Debug.PRINT_LOG()
        guard let dictionary = json as? [String : Any] else {
            throw JSONDecoderError.invalidFormat(json: json)
        }
        
        guard let totalCount = dictionary["total_count"] as? Int else {
            throw JSONDecoderError.missingValues(key: "total_count", actualValue: ["total_count"])
        }
        
        guard let itemObject = dictionary["items"] as? [Any] else {
            throw JSONDecoderError.missingValues(key: "items", actualValue: dictionary["items"] as Any)
        }
        
        let items = try itemObject.map {
            return try Item(json: $0)
        }
        
        self.totalCount = totalCount
        self.items = items
    }
    
}
