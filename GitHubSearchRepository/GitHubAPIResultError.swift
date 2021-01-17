//
//  GitHubAPIError.swift
//  GitHubSearchRepository
//
//  Created by Yuta S. on 2018/03/18.
//  Copyright © 2018 Yuta S. All rights reserved.
//

import Foundation

struct GitHubAPIResultError: JSONDecodable, Error {
    struct FieldError: JSONDecodable {
        let resource: String
        let field: String
        let code: String
        
        init(json: Any) throws {
            guard let dictionary = json as? [String : Any] else {
                throw JSONDecoderError.invalidFormat(json: json)
            }
            
            guard let resource = dictionary["resource"] as? String else {
                throw JSONDecoderError.missingValues(key: "resource", actualValue: dictionary["resource"] as Any)
            }
            
            guard let field = dictionary["field"] as? String else {
                throw JSONDecoderError.missingValues(key: "field", actualValue: dictionary["field"] as Any)
            }
            
            guard let code = dictionary["code"] as? String else {
                throw JSONDecoderError.missingValues(key: "code", actualValue: dictionary["code"] as Any)
            }
            
            self.resource = resource
            self.field = field
            self.code = code
        }
    }
    
    let message: String
    let fieldErrors: [FieldError]
    
    init(json: Any) throws {
        guard let dictionaly = json as? [String : Any] else {
            throw JSONDecoderError.invalidFormat(json: json)
        }
        
        guard let message = dictionaly["message"] as? String else {
            throw JSONDecoderError.missingValues(key: "mesage", actualValue: dictionaly["message"] as Any)
        }
        
        let fieldErrorObjects = dictionaly["errors"] as? [Any] ?? []
        let fieldErrors = try fieldErrorObjects.map {
            return try FieldError(json: $0)
        }
        
        self.message = message
        self.fieldErrors = fieldErrors
    }
}
